//------------------------------------------------------------------------------
// KintexTop_IR6ch_I2CSelect
// - 6x IR camera inputs
// - I2C selects which IR camera stream is forwarded to the debugger outputs (IEG0/IEG1)
// - I2C slave exposes an 8-bit register-addressed memory device at 7-bit address 0x36
// - Compatible with MCU HAL_I2C_Mem_Write / HAL_I2C_Mem_Read (8-bit register address)
// - The current mode register (0x00) selects the IR debug source:
//     0x0D..0x12 => IR0..IR5
//     0x00..0x05 => legacy direct select IR0..IR5
// - Uses IRCAM0_PCLK as the reference clock for the I2C slave
//------------------------------------------------------------------------------
module KintexTop_IR6ch_I2CSelect(
    // IR Camera 0..5
    input  wire         IRCAM0_PCLK,
    input  wire         IRCAM0_HSYNC,
    input  wire         IRCAM0_VSYNC,
    input  wire [15:0]  IRCAM0_DOUT,
    output wire         IRCAM0_GENLOCK,

    input  wire         IRCAM1_PCLK,
    input  wire         IRCAM1_HSYNC,
    input  wire         IRCAM1_VSYNC,
    input  wire [15:0]  IRCAM1_DOUT,
    output wire         IRCAM1_GENLOCK,

    input  wire         IRCAM2_PCLK,
    input  wire         IRCAM2_HSYNC,
    input  wire         IRCAM2_VSYNC,
    input  wire [15:0]  IRCAM2_DOUT,
    output wire         IRCAM2_GENLOCK,

    input  wire         IRCAM3_PCLK,
    input  wire         IRCAM3_HSYNC,
    input  wire         IRCAM3_VSYNC,
    input  wire [15:0]  IRCAM3_DOUT,
    output wire         IRCAM3_GENLOCK,

    input  wire         IRCAM4_PCLK,
    input  wire         IRCAM4_HSYNC,
    input  wire         IRCAM4_VSYNC,
    input  wire [15:0]  IRCAM4_DOUT,
    output wire         IRCAM4_GENLOCK,

    input  wire         IRCAM5_PCLK,
    input  wire         IRCAM5_HSYNC,
    input  wire         IRCAM5_VSYNC,
    input  wire [15:0]  IRCAM5_DOUT,
    output wire         IRCAM5_GENLOCK,

    // EO CAM0 / Strobe (used as reference clock and optional debug bit)
    input  wire         STROBE_OUT0,
    input  wire         CAM0_PCLK,

    // Debugger output port(s)
    output wire         IEG0_PCLK,
    output wire         IEG0_HSYNC,
    output wire         IEG0_VSYNC,
    output wire [19:0]  IEG0_DOUT,

    output wire         IEG1_PCLK,
    output wire         IEG1_HSYNC,
    output wire         IEG1_VSYNC,
    output wire [19:0]  IEG1_DOUT,

    // I2C
    input  wire         SCL,
    inout  wire         SDA
);

    //--------------------------------------------------------------------------
    // Constant reset (matches your existing single-cam debug design style)
    //--------------------------------------------------------------------------
    wire nRESET = 1'b1;

    //--------------------------------------------------------------------------
    // Clock buffers (match your existing use of IBUFG for camera PCLKs)
    //--------------------------------------------------------------------------
    wire IRCAM0_PCLK_bufg, IRCAM1_PCLK_bufg, IRCAM2_PCLK_bufg;
    wire IRCAM3_PCLK_bufg, IRCAM4_PCLK_bufg, IRCAM5_PCLK_bufg;
    wire CAM0_PCLK_bufg;

    IBUFG U_ircam0_pclk_ibuf (.I(IRCAM0_PCLK), .O(IRCAM0_PCLK_bufg));
    IBUFG U_ircam1_pclk_ibuf (.I(IRCAM1_PCLK), .O(IRCAM1_PCLK_bufg));
    IBUFG U_ircam2_pclk_ibuf (.I(IRCAM2_PCLK), .O(IRCAM2_PCLK_bufg));
    IBUFG U_ircam3_pclk_ibuf (.I(IRCAM3_PCLK), .O(IRCAM3_PCLK_bufg));
    IBUFG U_ircam4_pclk_ibuf (.I(IRCAM4_PCLK), .O(IRCAM4_PCLK_bufg));
    IBUFG U_ircam5_pclk_ibuf (.I(IRCAM5_PCLK), .O(IRCAM5_PCLK_bufg));
    // CAM0_PCLK: use a single input buffer, then fan out (avoids illegal port->IBUFG+BUFG fanout)
    wire CAM0_PCLK_ibuf;
    IBUF  U_cam0_pclk_ibuf (.I(CAM0_PCLK), .O(CAM0_PCLK_ibuf));
    BUFG  U_cam0_pclk_bufg (.I(CAM0_PCLK_ibuf), .O(CAM0_PCLK_bufg));

    //--------------------------------------------------------------------------
    // Register strobe in the CAM0 clock domain (optional debug bit)
    //--------------------------------------------------------------------------
    reg STROBE_OUT0_1d;
    always @(posedge CAM0_PCLK_bufg or negedge nRESET) begin
        if (!nRESET) STROBE_OUT0_1d <= 1'b0;
        else         STROBE_OUT0_1d <= STROBE_OUT0;
    end

    //--------------------------------------------------------------------------
    // Latch each IR camera bus in its own PCLK domain
    //--------------------------------------------------------------------------
    reg [15:0] IRCAM0_DOUT_1d, IRCAM1_DOUT_1d, IRCAM2_DOUT_1d;
    reg [15:0] IRCAM3_DOUT_1d, IRCAM4_DOUT_1d, IRCAM5_DOUT_1d;
    reg        IRCAM0_HSYNC_1d, IRCAM0_VSYNC_1d;
    reg        IRCAM1_HSYNC_1d, IRCAM1_VSYNC_1d;
    reg        IRCAM2_HSYNC_1d, IRCAM2_VSYNC_1d;
    reg        IRCAM3_HSYNC_1d, IRCAM3_VSYNC_1d;
    reg        IRCAM4_HSYNC_1d, IRCAM4_VSYNC_1d;
    reg        IRCAM5_HSYNC_1d, IRCAM5_VSYNC_1d;

    always @(posedge IRCAM0_PCLK_bufg or negedge nRESET) begin
        if (!nRESET) begin
            IRCAM0_DOUT_1d  <= 16'h0000; IRCAM0_HSYNC_1d <= 1'b0; IRCAM0_VSYNC_1d <= 1'b0;
        end else begin
            IRCAM0_DOUT_1d  <= IRCAM0_DOUT;  IRCAM0_HSYNC_1d <= IRCAM0_HSYNC;  IRCAM0_VSYNC_1d <= IRCAM0_VSYNC;
        end
    end

    always @(posedge IRCAM1_PCLK_bufg or negedge nRESET) begin
        if (!nRESET) begin
            IRCAM1_DOUT_1d  <= 16'h0000; IRCAM1_HSYNC_1d <= 1'b0; IRCAM1_VSYNC_1d <= 1'b0;
        end else begin
            IRCAM1_DOUT_1d  <= IRCAM1_DOUT;  IRCAM1_HSYNC_1d <= IRCAM1_HSYNC;  IRCAM1_VSYNC_1d <= IRCAM1_VSYNC;
        end
    end

    always @(posedge IRCAM2_PCLK_bufg or negedge nRESET) begin
        if (!nRESET) begin
            IRCAM2_DOUT_1d  <= 16'h0000; IRCAM2_HSYNC_1d <= 1'b0; IRCAM2_VSYNC_1d <= 1'b0;
        end else begin
            IRCAM2_DOUT_1d  <= IRCAM2_DOUT;  IRCAM2_HSYNC_1d <= IRCAM2_HSYNC;  IRCAM2_VSYNC_1d <= IRCAM2_VSYNC;
        end
    end

    always @(posedge IRCAM3_PCLK_bufg or negedge nRESET) begin
        if (!nRESET) begin
            IRCAM3_DOUT_1d  <= 16'h0000; IRCAM3_HSYNC_1d <= 1'b0; IRCAM3_VSYNC_1d <= 1'b0;
        end else begin
            IRCAM3_DOUT_1d  <= IRCAM3_DOUT;  IRCAM3_HSYNC_1d <= IRCAM3_HSYNC;  IRCAM3_VSYNC_1d <= IRCAM3_VSYNC;
        end
    end

    always @(posedge IRCAM4_PCLK_bufg or negedge nRESET) begin
        if (!nRESET) begin
            IRCAM4_DOUT_1d  <= 16'h0000; IRCAM4_HSYNC_1d <= 1'b0; IRCAM4_VSYNC_1d <= 1'b0;
        end else begin
            IRCAM4_DOUT_1d  <= IRCAM4_DOUT;  IRCAM4_HSYNC_1d <= IRCAM4_HSYNC;  IRCAM4_VSYNC_1d <= IRCAM4_VSYNC;
        end
    end

    always @(posedge IRCAM5_PCLK_bufg or negedge nRESET) begin
        if (!nRESET) begin
            IRCAM5_DOUT_1d  <= 16'h0000; IRCAM5_HSYNC_1d <= 1'b0; IRCAM5_VSYNC_1d <= 1'b0;
        end else begin
            IRCAM5_DOUT_1d  <= IRCAM5_DOUT;  IRCAM5_HSYNC_1d <= IRCAM5_HSYNC;  IRCAM5_VSYNC_1d <= IRCAM5_VSYNC;
        end
    end

    //--------------------------------------------------------------------------
    // I2C slave
    // - Uses IRCAM0_PCLK as the internal reference clock
    //--------------------------------------------------------------------------
    wire [3:0] cam_select;

    Kintex_top_I2C_test #(
        .SLAVE_ADDR(7'h36),
        .SCLK_HZ(74_250_000),
        .POR_MS(100)
    ) u_i2c (
        .FPGA_RESET(1'b1),
        .SCLK_IN   (IRCAM0_PCLK_bufg),
        .SCL       (SCL),
        .SDA       (SDA),
        .cam_select(cam_select)
    );

    // Clamp select to 0..5
    wire [2:0] sel = (cam_select[2:0] > 3'd5) ? 3'd0 : cam_select[2:0];

    //--------------------------------------------------------------------------
    // Mux selected IR camera stream to debugger outputs
    //--------------------------------------------------------------------------
    wire        SEL_PCLK  =
        (sel == 3'd0) ? IRCAM0_PCLK_bufg :
        (sel == 3'd1) ? IRCAM1_PCLK_bufg :
        (sel == 3'd2) ? IRCAM2_PCLK_bufg :
        (sel == 3'd3) ? IRCAM3_PCLK_bufg :
        (sel == 3'd4) ? IRCAM4_PCLK_bufg :
                        IRCAM5_PCLK_bufg;

    wire        SEL_HSYNC =
        (sel == 3'd0) ? IRCAM0_HSYNC_1d :
        (sel == 3'd1) ? IRCAM1_HSYNC_1d :
        (sel == 3'd2) ? IRCAM2_HSYNC_1d :
        (sel == 3'd3) ? IRCAM3_HSYNC_1d :
        (sel == 3'd4) ? IRCAM4_HSYNC_1d :
                        IRCAM5_HSYNC_1d;

    wire        SEL_VSYNC =
        (sel == 3'd0) ? IRCAM0_VSYNC_1d :
        (sel == 3'd1) ? IRCAM1_VSYNC_1d :
        (sel == 3'd2) ? IRCAM2_VSYNC_1d :
        (sel == 3'd3) ? IRCAM3_VSYNC_1d :
        (sel == 3'd4) ? IRCAM4_VSYNC_1d :
                        IRCAM5_VSYNC_1d;

    wire [15:0] SEL_DOUT  =
        (sel == 3'd0) ? IRCAM0_DOUT_1d :
        (sel == 3'd1) ? IRCAM1_DOUT_1d :
        (sel == 3'd2) ? IRCAM2_DOUT_1d :
        (sel == 3'd3) ? IRCAM3_DOUT_1d :
        (sel == 3'd4) ? IRCAM4_DOUT_1d :
                        IRCAM5_DOUT_1d;

    // Drive both debug ports identically
    assign IEG0_PCLK  = SEL_PCLK;
    assign IEG0_HSYNC = SEL_HSYNC;
    assign IEG0_VSYNC = SEL_VSYNC;
    assign IEG0_DOUT  = {12'b0, SEL_DOUT[13:6]};

    assign IEG1_PCLK  = SEL_PCLK;
    assign IEG1_HSYNC = SEL_HSYNC;
    assign IEG1_VSYNC = SEL_VSYNC;
    assign IEG1_DOUT  = {12'b0, SEL_DOUT[13:6]};

    //--------------------------------------------------------------------------
    // Genlock generation (copied from your single-cam debug design)
    //--------------------------------------------------------------------------
    reg sig_60hz;
    localparam integer CLK_HZ        = 74_250_000;
    localparam integer FRAME_HZ_X10  = 600;
    localparam integer PERIOD_CYCLES = (CLK_HZ * 10) / FRAME_HZ_X10;
    localparam integer HIGH_CYCLES   = (PERIOD_CYCLES * 1) / 100; // 1% duty

    localparam integer CW = 22;
    reg [CW-1:0] cnt;

    always @(posedge CAM0_PCLK_bufg or negedge nRESET) begin
        if (!nRESET) begin
            cnt      <= {CW{1'b0}};
            sig_60hz <= 1'b0;
        end else begin
            if (cnt == PERIOD_CYCLES-1)
                cnt <= {CW{1'b0}};
            else
                cnt <= cnt + {{(CW-1){1'b0}}, 1'b1};

            sig_60hz <= (cnt < HIGH_CYCLES);
        end
    end

    assign IRCAM0_GENLOCK = sig_60hz;
    assign IRCAM1_GENLOCK = sig_60hz;
    assign IRCAM2_GENLOCK = sig_60hz;
    assign IRCAM3_GENLOCK = sig_60hz;
    assign IRCAM4_GENLOCK = sig_60hz;
    assign IRCAM5_GENLOCK = sig_60hz;

endmodule

//------------------------------------------------------------------------------
// Included I2C slave adapted for the current MCU register map
//------------------------------------------------------------------------------

// I2C Slave with 128 x 8-bit registers
// Device address: 0x36 (7-bit)
// Register address: 0x00 ~ 0x7F
//
// Notes:
// - No external reset pin used. Internal POR reset generated from SCLK for POR_MS.
// - SDA is true open-drain: drive LOW only, otherwise Z (external pull-up required).
// - SDA changes only while SCL low (I2C spec), stable while SCL high.
// - START/STOP detection is qualified to avoid false STOP during SCL transitions.
// - dbg_last_wr_* mirrors added to confirm actual register write in ILA.

module Kintex_top_I2C_test #(
    parameter [6:0] SLAVE_ADDR = 7'h36,

    // ===== Internal POR reset params =====
    parameter integer SCLK_HZ = 100_000_000, // 100 MHz default
    parameter integer POR_MS  = 100,         // 100 ms reset

    parameter integer REG_COUNT = 128
)(
    input  wire FPGA_RESET, // unused
    input  wire SCLK_IN,
    input  wire SCL,
    inout  wire SDA,
	output wire [3:0] cam_select
);

    //===========================================================
    // SCLK BUFG
    //===========================================================
    wire SCLK;
    BUFG u_bufg_sclk (
        .I (SCLK_IN),
        .O (SCLK)
    );

    //===========================================================
    // Internal POR reset (POR_MS)
    //===========================================================
    function integer clog2;
        input integer value;
        integer i;
        begin
            clog2 = 0;
            for (i = value - 1; i > 0; i = i >> 1)
                clog2 = clog2 + 1;
        end
    endfunction

    localparam integer POR_CYCLES = (SCLK_HZ * POR_MS) / 1000;
    localparam integer POR_W      = (POR_CYCLES <= 1) ? 1 : clog2(POR_CYCLES + 1);

    reg  [POR_W-1:0] por_cnt /* synthesis preserve */;
    wire             nRESET_INT;

    assign nRESET_INT = (POR_CYCLES <= 1) ? 1'b1
                                          : (por_cnt >= POR_CYCLES[POR_W-1:0]);

    always @(posedge SCLK) begin
        if (!nRESET_INT)
            por_cnt <= por_cnt + {{(POR_W-1){1'b0}}, 1'b1};
        else
            por_cnt <= por_cnt;
    end

    //===========================================================
    // IBUF for SCL
    //===========================================================
    wire scl_ibuf;
    IBUF u_ibuf_scl (
        .I(SCL),
        .O(scl_ibuf)
    );

    //===========================================================
    // IOBUF for SDA (Open-Drain: low only)
    //===========================================================
    reg  sda_oe;     // 1 => drive LOW, 0 => release(Z)
    wire sda_in;

    wire sda_i;
    wire sda_o;
    wire sda_t;

    assign sda_o = 1'b0;
    assign sda_t = ~sda_oe;

    IOBUF u_iobuf_sda (
        .I (sda_o),
        .O (sda_i),
        .T (sda_t),
        .IO(SDA)
    );

    assign sda_in = sda_i;

    //===========================================================
    // Sync SCL and SDA to SCLK
    //===========================================================
    reg scl_meta, scl_sync, scl_sync_d;
    reg sda_meta, sda_sync, sda_sync_d;

    wire scl_rise =  scl_sync & ~scl_sync_d;
    wire scl_fall = ~scl_sync &  scl_sync_d;

    wire sda_rise =  sda_sync & ~sda_sync_d;
    wire sda_fall = ~sda_sync &  sda_sync_d;

    // ---- START/STOP qualification to avoid false detection ----
    wire scl_high_qual = scl_meta & scl_sync; // stable HIGH only

    wire start_cond = sda_fall & scl_high_qual; // START: SDA fall while SCL=1
    wire stop_cond  = sda_rise & scl_high_qual; // STOP : SDA rise while SCL=1

    //===========================================================
    // Register file (128 x 8-bit)
    //===========================================================
    reg [7:0] regfile [0:REG_COUNT-1];
    reg [7:0] reg_index;

    wire [7:0] mode_reg = regfile[8'h00];
    assign cam_select =
        (mode_reg <= 8'd5)                      ? mode_reg[3:0] :
        ((mode_reg >= 8'h0D) && (mode_reg <= 8'h12)) ? (mode_reg - 8'h0D) :
                                                  4'd0;

    //===========================================================
    // FSM / Shifters
    //===========================================================
    localparam [3:0]
        ST_IDLE      = 4'd0,
        ST_ADDR_RX   = 4'd1,
        ST_ADDR_ACK  = 4'd2,
        ST_REG_RX    = 4'd3,
        ST_REG_ACK   = 4'd4,
        ST_WRITE_RX  = 4'd5,
        ST_WRITE_ACK = 4'd6,
        ST_READ_TX   = 4'd7,
        ST_READ_ACK  = 4'd8;

    reg [3:0] state;
    reg [2:0] bit_cnt;
    reg [7:0] shift_reg;
    reg       rw_flag; // 0=write, 1=read
    reg       addr_match;
    integer   idx;

    //===========================================================
    // Debug signals (ILA)
    //===========================================================
     /*
     wire dbg_sclk    = SCLK;
     wire dbg_rstn    = nRESET_INT;
     wire dbg_scl     = scl_ibuf;
     wire dbg_sda     = sda_in;
     wire dbg_sclsync = scl_sync;
     wire dbg_sdasyn  = sda_sync;
     wire dbg_start   = start_cond;
     wire dbg_stop    = stop_cond;
     wire dbg_sclr    = scl_rise;
     wire dbg_sclf    = scl_fall;
     wire dbg_sdaoe   = sda_oe;

     reg  [3:0] dbg_state;
     reg  [2:0] dbg_bit_cnt;
     reg  [7:0] dbg_shift_reg;
     reg  [3:0] dbg_reg_index;
     reg        dbg_addr_match;
     reg        dbg_rw;

    // Write debug mirrors (ILA friendly)
     reg [3:0] dbg_last_wr_idx;
     reg [7:0] dbg_last_wr_data;
     reg       dbg_last_wr_pulse;

    always @(posedge SCLK) begin
        dbg_state      <= state;
        dbg_bit_cnt    <= bit_cnt;
        dbg_shift_reg  <= shift_reg;
        dbg_reg_index  <= reg_index;
        dbg_addr_match <= addr_match;
        dbg_rw         <= rw_flag;
    end
    */

    //===========================================================
    // Input synchronizers
    //===========================================================
    always @(posedge SCLK or negedge nRESET_INT) begin
        if (!nRESET_INT) begin
            scl_meta   <= 1'b0;
            scl_sync   <= 1'b0;
            scl_sync_d <= 1'b0;

            sda_meta   <= 1'b1;
            sda_sync   <= 1'b1;
            sda_sync_d <= 1'b1;
        end else begin
            scl_meta   <= scl_ibuf;
            scl_sync   <= scl_meta;
            scl_sync_d <= scl_sync;

            sda_meta   <= sda_in;
            sda_sync   <= sda_meta;
            sda_sync_d <= sda_sync;
        end
    end

    //===========================================================
    // Main FSM (RX on SCL rising, drive SDA only while SCL low)
    //===========================================================
    always @(posedge SCLK or negedge nRESET_INT) begin
        if (!nRESET_INT) begin
            state      <= ST_IDLE;
            bit_cnt    <= 3'd0;
            shift_reg  <= 8'd0;
            rw_flag    <= 1'b0;
            addr_match <= 1'b0;
            reg_index  <= 8'd0;

            for (idx = 0; idx < REG_COUNT; idx = idx + 1)
                regfile[idx] <= 8'h00;

            sda_oe <= 1'b0;

            //dbg_last_wr_idx   <= 4'd0;
            //dbg_last_wr_data  <= 8'd0;
            //dbg_last_wr_pulse <= 1'b0;

        end else begin
            // default pulse low (one-shot)
            //dbg_last_wr_pulse <= 1'b0;

            // STOP: release bus, go idle
            if (stop_cond) begin
                state      <= ST_IDLE;
                sda_oe     <= 1'b0;
                addr_match <= 1'b0;
            end

            // START or Re-START: go receive address
            if (start_cond) begin
                state      <= ST_ADDR_RX;
                bit_cnt    <= 3'd7;
                shift_reg  <= 8'd0;
                sda_oe     <= 1'b0;
                addr_match <= 1'b0;
            end

            // DRIVE SDA only while SCL LOW (ACK / READ data)
            if (!scl_sync) begin
                case (state)
                    ST_ADDR_ACK:  sda_oe <= addr_match ? 1'b1 : 1'b0;
                    ST_REG_ACK:   sda_oe <= addr_match ? 1'b1 : 1'b0;
                    ST_WRITE_ACK: sda_oe <= addr_match ? 1'b1 : 1'b0;

                    ST_READ_TX: begin
                        if (!addr_match)
                            sda_oe <= 1'b0;
                        else
                            // open-drain: 0 drives low, 1 releases
                            sda_oe <= (regfile[reg_index][bit_cnt] == 1'b0) ? 1'b1 : 1'b0;
                    end

                    ST_READ_ACK:  sda_oe <= 1'b0; // master drives ACK/NACK

                    default:      sda_oe <= 1'b0; // RX states: release
                endcase
            end

            // SAMPLE on SCL rising edge
            if (scl_rise) begin
                case (state)

                    ST_ADDR_RX: begin
                        shift_reg[bit_cnt] <= sda_sync;
                        if (bit_cnt == 0) begin
                            // address bits already in shift_reg[7:1]
                            rw_flag    <= sda_sync;                 // R/W bit
                            addr_match <= (shift_reg[7:1] == SLAVE_ADDR); // Verilog-safe
                            state      <= ST_ADDR_ACK;
                            bit_cnt    <= 3'd7;
                        end else begin
                            bit_cnt <= bit_cnt - 1'b1;
                        end
                    end

                    ST_ADDR_ACK: begin
                        if (!addr_match) begin
                            state <= ST_IDLE;
                        end else if (rw_flag == 1'b0) begin
                            state     <= ST_REG_RX;
                            bit_cnt   <= 3'd7;
                            shift_reg <= 8'd0;
                        end else begin
                            state   <= ST_READ_TX;
                            bit_cnt <= 3'd7;
                        end
                    end

                    ST_REG_RX: begin
                        shift_reg[bit_cnt] <= sda_sync;
                        if (bit_cnt == 0) begin
                            reg_index <= {shift_reg[7:1], sda_sync};
                            state     <= ST_REG_ACK;
                            bit_cnt   <= 3'd7;
                            shift_reg <= 8'd0;
                        end else begin
                            bit_cnt <= bit_cnt - 1'b1;
                        end
                    end

                    ST_REG_ACK: begin
                        state     <= ST_WRITE_RX;
                        bit_cnt   <= 3'd7;
                        shift_reg <= 8'd0;
                    end

                    ST_WRITE_RX: begin
                        shift_reg[bit_cnt] <= sda_sync;
                        if (bit_cnt == 0) begin
                            // WRITE the received data byte
                            regfile[reg_index] <= {shift_reg[7:1], sda_sync};

                            // Debug mirrors (confirm actual write happened)
                            //dbg_last_wr_idx   <= reg_index;
                            //dbg_last_wr_data  <= {shift_reg[7:1], sda_sync};
                            //dbg_last_wr_pulse <= 1'b1;

                            reg_index <= reg_index + 1'b1;
                            state     <= ST_WRITE_ACK;
                            bit_cnt   <= 3'd7;
                            shift_reg <= 8'd0;
                        end else begin
                            bit_cnt <= bit_cnt - 1'b1;
                        end
                    end

                    ST_WRITE_ACK: begin
                        state     <= ST_WRITE_RX;
                        bit_cnt   <= 3'd7;
                        shift_reg <= 8'd0;
                    end

                    ST_READ_TX: begin
                        if (!addr_match) begin
                            state <= ST_IDLE;
                        end else if (bit_cnt == 0) begin
                            state <= ST_READ_ACK;
                        end else begin
                            bit_cnt <= bit_cnt - 1'b1;
                        end
                    end

                    ST_READ_ACK: begin
                        if (sda_sync == 1'b0) begin
                            reg_index <= reg_index + 1'b1;
                            state     <= ST_READ_TX;
                            bit_cnt   <= 3'd7;
                        end else begin
                            state <= ST_IDLE;
                        end
                    end

                    default: begin
                        state <= ST_IDLE;
                    end
                endcase
            end
        end
    end
 

endmodule
