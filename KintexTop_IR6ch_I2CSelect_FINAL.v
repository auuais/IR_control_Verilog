//------------------------------------------------------------------------------
// Combined EO + IR I2C-select top
// - mode 0x07..0x0C => EO camera 0..5 routed to HD-SDI output
// - mode 0x0D..0x12 => IR camera 0..5 routed to IEG0/IEG1 debug outputs
// - legacy mode 0x00..0x05 => IR camera 0..5 (backward compatible)
// - I2C slave exposes full 8-bit register-addressed map at 7-bit address 0x36
//------------------------------------------------------------------------------
`include "KintexTop_0cam_ch1_0108.v"
`include "Kintex_top_1cam_ch1_1202.v"
`include "Kintex_top_2cam_ch1_1202.v"
`include "Kintex_top_3cam_ch1_1202.v"
`include "Kintex_top_4cam_ch1_1202.v"
`include "Kintex_top_5cam_ch1_1202.v"

module KintexTop_IR6ch_I2CSelect(
    // EO Camera 0..5
    input  wire         CAM0_PCLK,
    input  wire [7:0]   CAM0_YOUT,
    input  wire [7:0]   CAM0_COUT,

    input  wire         CAM1_PCLK,
    input  wire [7:0]   CAM1_YOUT,
    input  wire [7:0]   CAM1_COUT,
    output wire         TRIG_IN1,

    input  wire         CAM2_PCLK,
    input  wire [7:0]   CAM2_YOUT,
    input  wire [7:0]   CAM2_COUT,
    output wire         TRIG_IN2,

    input  wire         CAM3_PCLK,
    input  wire [7:0]   CAM3_YOUT,
    input  wire [7:0]   CAM3_COUT,
    output wire         TRIG_IN3,

    input  wire         CAM4_PCLK,
    input  wire [7:0]   CAM4_YOUT,
    input  wire [7:0]   CAM4_COUT,
    output wire         TRIG_IN4,

    input  wire         CAM5_PCLK,
    input  wire [7:0]   CAM5_YOUT,
    input  wire [7:0]   CAM5_COUT,
    output wire         TRIG_IN5,

    input  wire         STROBE_OUT0,

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

    // HD-SDI output for EO selection
    output wire         HD_DE,
    output wire         HD_VSYNC,
    output wire         HD_HSYNC,
    output wire         HD_PCLK,
    output wire [19:0]  HD_DOUT,

    // Debugger outputs for IR selection
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

    wire nRESET = 1'b1;

    // ------------------------------------------------------------------------
    // Clock buffers
    // ------------------------------------------------------------------------
    wire IRCAM0_PCLK_bufg, IRCAM1_PCLK_bufg, IRCAM2_PCLK_bufg;
    wire IRCAM3_PCLK_bufg, IRCAM4_PCLK_bufg, IRCAM5_PCLK_bufg;
    wire CAM0_PCLK_ibuf, CAM0_PCLK_bufg;

    IBUFG U_ircam0_pclk_ibuf (.I(IRCAM0_PCLK), .O(IRCAM0_PCLK_bufg));
    IBUFG U_ircam1_pclk_ibuf (.I(IRCAM1_PCLK), .O(IRCAM1_PCLK_bufg));
    IBUFG U_ircam2_pclk_ibuf (.I(IRCAM2_PCLK), .O(IRCAM2_PCLK_bufg));
    IBUFG U_ircam3_pclk_ibuf (.I(IRCAM3_PCLK), .O(IRCAM3_PCLK_bufg));
    IBUFG U_ircam4_pclk_ibuf (.I(IRCAM4_PCLK), .O(IRCAM4_PCLK_bufg));
    IBUFG U_ircam5_pclk_ibuf (.I(IRCAM5_PCLK), .O(IRCAM5_PCLK_bufg));
    IBUF  U_cam0_pclk_ibuf  (.I(CAM0_PCLK),   .O(CAM0_PCLK_ibuf));
    BUFG  U_cam0_pclk_bufg  (.I(CAM0_PCLK_ibuf), .O(CAM0_PCLK_bufg));

    // ------------------------------------------------------------------------
    // IR capture latches
    // ------------------------------------------------------------------------
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
            IRCAM0_DOUT_1d <= 16'h0000; IRCAM0_HSYNC_1d <= 1'b0; IRCAM0_VSYNC_1d <= 1'b0;
        end else begin
            IRCAM0_DOUT_1d <= IRCAM0_DOUT; IRCAM0_HSYNC_1d <= IRCAM0_HSYNC; IRCAM0_VSYNC_1d <= IRCAM0_VSYNC;
        end
    end
    always @(posedge IRCAM1_PCLK_bufg or negedge nRESET) begin
        if (!nRESET) begin
            IRCAM1_DOUT_1d <= 16'h0000; IRCAM1_HSYNC_1d <= 1'b0; IRCAM1_VSYNC_1d <= 1'b0;
        end else begin
            IRCAM1_DOUT_1d <= IRCAM1_DOUT; IRCAM1_HSYNC_1d <= IRCAM1_HSYNC; IRCAM1_VSYNC_1d <= IRCAM1_VSYNC;
        end
    end
    always @(posedge IRCAM2_PCLK_bufg or negedge nRESET) begin
        if (!nRESET) begin
            IRCAM2_DOUT_1d <= 16'h0000; IRCAM2_HSYNC_1d <= 1'b0; IRCAM2_VSYNC_1d <= 1'b0;
        end else begin
            IRCAM2_DOUT_1d <= IRCAM2_DOUT; IRCAM2_HSYNC_1d <= IRCAM2_HSYNC; IRCAM2_VSYNC_1d <= IRCAM2_VSYNC;
        end
    end
    always @(posedge IRCAM3_PCLK_bufg or negedge nRESET) begin
        if (!nRESET) begin
            IRCAM3_DOUT_1d <= 16'h0000; IRCAM3_HSYNC_1d <= 1'b0; IRCAM3_VSYNC_1d <= 1'b0;
        end else begin
            IRCAM3_DOUT_1d <= IRCAM3_DOUT; IRCAM3_HSYNC_1d <= IRCAM3_HSYNC; IRCAM3_VSYNC_1d <= IRCAM3_VSYNC;
        end
    end
    always @(posedge IRCAM4_PCLK_bufg or negedge nRESET) begin
        if (!nRESET) begin
            IRCAM4_DOUT_1d <= 16'h0000; IRCAM4_HSYNC_1d <= 1'b0; IRCAM4_VSYNC_1d <= 1'b0;
        end else begin
            IRCAM4_DOUT_1d <= IRCAM4_DOUT; IRCAM4_HSYNC_1d <= IRCAM4_HSYNC; IRCAM4_VSYNC_1d <= IRCAM4_VSYNC;
        end
    end
    always @(posedge IRCAM5_PCLK_bufg or negedge nRESET) begin
        if (!nRESET) begin
            IRCAM5_DOUT_1d <= 16'h0000; IRCAM5_HSYNC_1d <= 1'b0; IRCAM5_VSYNC_1d <= 1'b0;
        end else begin
            IRCAM5_DOUT_1d <= IRCAM5_DOUT; IRCAM5_HSYNC_1d <= IRCAM5_HSYNC; IRCAM5_VSYNC_1d <= IRCAM5_VSYNC;
        end
    end

    // ------------------------------------------------------------------------
    // I2C slave / mode decode
    // ------------------------------------------------------------------------
    wire [3:0] cam_select_unused;
    wire [7:0] mode_current;

    Kintex_top_I2C_test #(
        .SLAVE_ADDR(7'h36),
        .SCLK_HZ(74_250_000),
        .POR_MS(100)
    ) u_i2c (
        .FPGA_RESET(1'b1),
        .SCLK_IN   (CAM0_PCLK_ibuf),
        .SCL       (SCL),
        .SDA       (SDA),
        .cam_select(cam_select_unused),
        .mode_out  (mode_current)
    );

    wire eo_mode_active = (mode_current >= 8'h07) && (mode_current <= 8'h0C);
    wire ir_mode_active = (mode_current <= 8'd5) || ((mode_current >= 8'h0D) && (mode_current <= 8'h12));

    wire [2:0] eo_sel = eo_mode_active ? (mode_current - 8'h07) : 3'd0;
    wire [2:0] ir_sel = (mode_current <= 8'd5) ? mode_current[2:0] :
                        (((mode_current >= 8'h0D) && (mode_current <= 8'h12)) ? (mode_current - 8'h0D) : 3'd0);

    // ------------------------------------------------------------------------
    // EO camera processing blocks (reused from previous working EO design)
    // ------------------------------------------------------------------------
    wire        eo0_pclk, eo0_hsync, eo0_vsync;
    wire [19:2] eo0_dout_19_2;
    wire [19:0] eo0_dout = {eo0_dout_19_2, 2'b00};
    wire        eo0_dbg_pclk, eo0_dbg_hsync, eo0_dbg_vsync;
    wire [19:0] eo0_dbg_dout;

    wire        eo1_pclk, eo1_hsync, eo1_vsync;
    wire [19:0] eo1_dout, eo1_dbg_dout;
    wire        eo1_dbg_pclk, eo1_dbg_hsync, eo1_dbg_vsync;

    wire        eo2_pclk, eo2_hsync, eo2_vsync;
    wire [19:0] eo2_dout, eo2_dbg_dout;
    wire        eo2_dbg_pclk, eo2_dbg_hsync, eo2_dbg_vsync;

    wire        eo3_pclk, eo3_hsync, eo3_vsync;
    wire [19:0] eo3_dout, eo3_dbg_dout;
    wire        eo3_dbg_pclk, eo3_dbg_hsync, eo3_dbg_vsync;

    wire        eo4_pclk, eo4_hsync, eo4_vsync;
    wire [19:0] eo4_dout, eo4_dbg_dout;
    wire        eo4_dbg_pclk, eo4_dbg_hsync, eo4_dbg_vsync;

    wire        eo5_pclk, eo5_hsync, eo5_vsync;
    wire [19:0] eo5_dout, eo5_dbg_dout;
    wire        eo5_dbg_pclk, eo5_dbg_hsync, eo5_dbg_vsync;

    Kintex_top_0cam_1ch u_eo0 (
        .FPGA_RESET (nRESET),
        .CAM0_PCLK  (CAM0_PCLK_ibuf),
        .CAM0_YOUT  (CAM0_YOUT),
        .CAM0_COUT  (CAM0_COUT),
        .IEG0_PCLK  (eo0_pclk),
        .IEG0_HSYNC (eo0_hsync),
        .IEG0_VSYNC (eo0_vsync),
        .IEG0_DOUT  (eo0_dout_19_2),
        .IEG1_PCLK  (eo0_dbg_pclk),
        .IEG1_HSYNC (eo0_dbg_hsync),
        .IEG1_VSYNC (eo0_dbg_vsync),
        .IEG1_DOUT  (eo0_dbg_dout)
    );

    Kintex_top_1cam_1ch u_eo1 (
        .FPGA_RESET (nRESET),
        .CAM1_PCLK  (CAM1_PCLK),
        .CAM1_YOUT  (CAM1_YOUT),
        .CAM1_COUT  (CAM1_COUT),
        .STROBE_OUT0(STROBE_OUT0),
        .TRIG_IN1   (TRIG_IN1),
        .IEG0_PCLK  (eo1_pclk),
        .IEG0_HSYNC (eo1_hsync),
        .IEG0_VSYNC (eo1_vsync),
        .IEG0_DOUT  (eo1_dout),
        .IEG1_PCLK  (eo1_dbg_pclk),
        .IEG1_HSYNC (eo1_dbg_hsync),
        .IEG1_VSYNC (eo1_dbg_vsync),
        .IEG1_DOUT  (eo1_dbg_dout)
    );

    Kintex_top_2cam_1ch u_eo2 (
        .FPGA_RESET (nRESET),
        .CAM2_PCLK  (CAM2_PCLK),
        .CAM2_YOUT  (CAM2_YOUT),
        .CAM2_COUT  (CAM2_COUT),
        .STROBE_OUT0(STROBE_OUT0),
        .TRIG_IN2   (TRIG_IN2),
        .IEG0_PCLK  (eo2_pclk),
        .IEG0_HSYNC (eo2_hsync),
        .IEG0_VSYNC (eo2_vsync),
        .IEG0_DOUT  (eo2_dout),
        .IEG1_PCLK  (eo2_dbg_pclk),
        .IEG1_HSYNC (eo2_dbg_hsync),
        .IEG1_VSYNC (eo2_dbg_vsync),
        .IEG1_DOUT  (eo2_dbg_dout)
    );

    Kintex_top_3cam_1ch u_eo3 (
        .FPGA_RESET (nRESET),
        .CAM3_PCLK  (CAM3_PCLK),
        .CAM3_YOUT  (CAM3_YOUT),
        .CAM3_COUT  (CAM3_COUT),
        .STROBE_OUT0(STROBE_OUT0),
        .TRIG_IN3   (TRIG_IN3),
        .IEG0_PCLK  (eo3_pclk),
        .IEG0_HSYNC (eo3_hsync),
        .IEG0_VSYNC (eo3_vsync),
        .IEG0_DOUT  (eo3_dout),
        .IEG1_PCLK  (eo3_dbg_pclk),
        .IEG1_HSYNC (eo3_dbg_hsync),
        .IEG1_VSYNC (eo3_dbg_vsync),
        .IEG1_DOUT  (eo3_dbg_dout)
    );

    Kintex_top_4cam_1ch u_eo4 (
        .FPGA_RESET (nRESET),
        .CAM4_PCLK  (CAM4_PCLK),
        .CAM4_YOUT  (CAM4_YOUT),
        .CAM4_COUT  (CAM4_COUT),
        .STROBE_OUT0(STROBE_OUT0),
        .TRIG_IN4   (TRIG_IN4),
        .IEG0_PCLK  (eo4_pclk),
        .IEG0_HSYNC (eo4_hsync),
        .IEG0_VSYNC (eo4_vsync),
        .IEG0_DOUT  (eo4_dout),
        .IEG1_PCLK  (eo4_dbg_pclk),
        .IEG1_HSYNC (eo4_dbg_hsync),
        .IEG1_VSYNC (eo4_dbg_vsync),
        .IEG1_DOUT  (eo4_dbg_dout)
    );

    Kintex_top_5cam_1ch u_eo5 (
        .FPGA_RESET (nRESET),
        .CAM5_PCLK  (CAM5_PCLK),
        .CAM5_YOUT  (CAM5_YOUT),
        .CAM5_COUT  (CAM5_COUT),
        .STROBE_OUT0(STROBE_OUT0),
        .TRIG_IN5   (TRIG_IN5),
        .IEG0_PCLK  (eo5_pclk),
        .IEG0_HSYNC (eo5_hsync),
        .IEG0_VSYNC (eo5_vsync),
        .IEG0_DOUT  (eo5_dout),
        .IEG1_PCLK  (eo5_dbg_pclk),
        .IEG1_HSYNC (eo5_dbg_hsync),
        .IEG1_VSYNC (eo5_dbg_vsync),
        .IEG1_DOUT  (eo5_dbg_dout)
    );

    wire eo_sel_pclk_mux = (eo_sel == 3'd0) ? eo0_pclk :
                           (eo_sel == 3'd1) ? eo1_pclk :
                           (eo_sel == 3'd2) ? eo2_pclk :
                           (eo_sel == 3'd3) ? eo3_pclk :
                           (eo_sel == 3'd4) ? eo4_pclk :
                                              eo5_pclk;
    wire EO_SEL_PCLK_BUFG;
    BUFG u_eo_sel_pclk_bufg (.I(eo_sel_pclk_mux), .O(EO_SEL_PCLK_BUFG));

    wire        EO_SEL_HSYNC = (eo_sel == 3'd0) ? eo0_hsync :
                               (eo_sel == 3'd1) ? eo1_hsync :
                               (eo_sel == 3'd2) ? eo2_hsync :
                               (eo_sel == 3'd3) ? eo3_hsync :
                               (eo_sel == 3'd4) ? eo4_hsync : eo5_hsync;
    wire        EO_SEL_VSYNC = (eo_sel == 3'd0) ? eo0_vsync :
                               (eo_sel == 3'd1) ? eo1_vsync :
                               (eo_sel == 3'd2) ? eo2_vsync :
                               (eo_sel == 3'd3) ? eo3_vsync :
                               (eo_sel == 3'd4) ? eo4_vsync : eo5_vsync;
    wire [19:0] EO_SEL_DOUT  = (eo_sel == 3'd0) ? eo0_dout :
                               (eo_sel == 3'd1) ? eo1_dout :
                               (eo_sel == 3'd2) ? eo2_dout :
                               (eo_sel == 3'd3) ? eo3_dout :
                               (eo_sel == 3'd4) ? eo4_dout : eo5_dout;

    assign HD_PCLK  = eo_mode_active ? EO_SEL_PCLK_BUFG : 1'b0;
    assign HD_DE    = eo_mode_active ? 1'b1 : 1'b0;
    assign HD_HSYNC = eo_mode_active ? 1'b1 : 1'b0;
    assign HD_VSYNC = eo_mode_active ? 1'b1 : 1'b0;
    assign HD_DOUT  = eo_mode_active ? EO_SEL_DOUT : 20'h0;

    // ------------------------------------------------------------------------
    // IR routing to debugger outputs
    // ------------------------------------------------------------------------
    wire        IR_SEL_PCLK  = (ir_sel == 3'd0) ? IRCAM0_PCLK_bufg :
                               (ir_sel == 3'd1) ? IRCAM1_PCLK_bufg :
                               (ir_sel == 3'd2) ? IRCAM2_PCLK_bufg :
                               (ir_sel == 3'd3) ? IRCAM3_PCLK_bufg :
                               (ir_sel == 3'd4) ? IRCAM4_PCLK_bufg : IRCAM5_PCLK_bufg;
    wire        IR_SEL_HSYNC = (ir_sel == 3'd0) ? IRCAM0_HSYNC_1d :
                               (ir_sel == 3'd1) ? IRCAM1_HSYNC_1d :
                               (ir_sel == 3'd2) ? IRCAM2_HSYNC_1d :
                               (ir_sel == 3'd3) ? IRCAM3_HSYNC_1d :
                               (ir_sel == 3'd4) ? IRCAM4_HSYNC_1d : IRCAM5_HSYNC_1d;
    wire        IR_SEL_VSYNC = (ir_sel == 3'd0) ? IRCAM0_VSYNC_1d :
                               (ir_sel == 3'd1) ? IRCAM1_VSYNC_1d :
                               (ir_sel == 3'd2) ? IRCAM2_VSYNC_1d :
                               (ir_sel == 3'd3) ? IRCAM3_VSYNC_1d :
                               (ir_sel == 3'd4) ? IRCAM4_VSYNC_1d : IRCAM5_VSYNC_1d;
    wire [19:0] IR_SEL_DOUT  = (ir_sel == 3'd0) ? {12'b0, IRCAM0_DOUT_1d[13:6]} :
                               (ir_sel == 3'd1) ? {12'b0, IRCAM1_DOUT_1d[13:6]} :
                               (ir_sel == 3'd2) ? {12'b0, IRCAM2_DOUT_1d[13:6]} :
                               (ir_sel == 3'd3) ? {12'b0, IRCAM3_DOUT_1d[13:6]} :
                               (ir_sel == 3'd4) ? {12'b0, IRCAM4_DOUT_1d[13:6]} :
                                                  {12'b0, IRCAM5_DOUT_1d[13:6]};

    assign IEG0_PCLK  = ir_mode_active ? IR_SEL_PCLK  : 1'b0;
    assign IEG0_HSYNC = ir_mode_active ? IR_SEL_HSYNC : 1'b0;
    assign IEG0_VSYNC = ir_mode_active ? IR_SEL_VSYNC : 1'b0;
    assign IEG0_DOUT  = ir_mode_active ? IR_SEL_DOUT  : 20'h0;

    assign IEG1_PCLK  = ir_mode_active ? IR_SEL_PCLK  : 1'b0;
    assign IEG1_HSYNC = ir_mode_active ? IR_SEL_HSYNC : 1'b0;
    assign IEG1_VSYNC = ir_mode_active ? IR_SEL_VSYNC : 1'b0;
    assign IEG1_DOUT  = ir_mode_active ? IR_SEL_DOUT  : 20'h0;

    // ------------------------------------------------------------------------
    // IR genlock generation
    // ------------------------------------------------------------------------
    reg sig_60hz;
    localparam integer CLK_HZ        = 74_250_000;
    localparam integer FRAME_HZ_X10  = 600;
    localparam integer PERIOD_CYCLES = (CLK_HZ * 10) / FRAME_HZ_X10;
    localparam integer HIGH_CYCLES   = (PERIOD_CYCLES * 1) / 100;
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
	output wire [3:0] cam_select,
    output wire [7:0] mode_out
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
    // Force flip-flop/register implementation instead of inferred RAM.
    // The old known-good design used a small discrete register bank; once
    // expanded to 128 bytes we must prevent BRAM/LUTRAM inference so random
    // 8-bit address accesses continue to behave as a simple byte register file.
    //===========================================================
    (* ram_style = "registers" *) reg [7:0] regfile [0:REG_COUNT-1];
    reg [7:0] reg_index;

    wire [7:0] mode_reg = regfile[8'h00];
    assign mode_out = mode_reg;
    wire [31:0] eo_cyl_h_fov_q16 = {regfile[8'h23], regfile[8'h22], regfile[8'h21], regfile[8'h20]};
    wire [31:0] eo_cyl_v_fov_q16 = {regfile[8'h27], regfile[8'h26], regfile[8'h25], regfile[8'h24]};
    wire [31:0] eo_crop_h_q16    = {regfile[8'h2B], regfile[8'h2A], regfile[8'h29], regfile[8'h28]};
    wire [31:0] eo_crop_w_q16    = {regfile[8'h2F], regfile[8'h2E], regfile[8'h2D], regfile[8'h2C]};
    wire [31:0] eo_pitch_tr_q16  = {regfile[8'h33], regfile[8'h32], regfile[8'h31], regfile[8'h30]};
    wire [31:0] eo_yaw_tr_q16    = {regfile[8'h37], regfile[8'h36], regfile[8'h35], regfile[8'h34]};
    wire [31:0] eo_overlap_i32   = {regfile[8'h3B], regfile[8'h3A], regfile[8'h39], regfile[8'h38]};
    wire [31:0] eo_feather_q16   = {regfile[8'h3F], regfile[8'h3E], regfile[8'h3D], regfile[8'h3C]};

    wire [31:0] ir_cyl_h_fov_q16 = {regfile[8'h53], regfile[8'h52], regfile[8'h51], regfile[8'h50]};
    wire [31:0] ir_cyl_v_fov_q16 = {regfile[8'h57], regfile[8'h56], regfile[8'h55], regfile[8'h54]};
    wire [31:0] ir_crop_h_q16    = {regfile[8'h5B], regfile[8'h5A], regfile[8'h59], regfile[8'h58]};
    wire [31:0] ir_crop_w_q16    = {regfile[8'h5F], regfile[8'h5E], regfile[8'h5D], regfile[8'h5C]};
    wire [31:0] ir_pitch_tr_q16  = {regfile[8'h63], regfile[8'h62], regfile[8'h61], regfile[8'h60]};
    wire [31:0] ir_yaw_tr_q16    = {regfile[8'h67], regfile[8'h66], regfile[8'h65], regfile[8'h64]};
    wire [31:0] ir_overlap_i32   = {regfile[8'h6B], regfile[8'h6A], regfile[8'h69], regfile[8'h68]};
    wire [31:0] ir_feather_q16   = {regfile[8'h6F], regfile[8'h6E], regfile[8'h6D], regfile[8'h6C]};
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
