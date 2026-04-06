#IRCAM0_PCLK as use fpga_clock

#IRCAM0_PCLK
set_property PACKAGE_PIN AN18 [get_ports IRCAM0_PCLK]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM0_PCLK]
#IRCAM1_PCLK
set_property PACKAGE_PIN AN21 [get_ports IRCAM1_PCLK]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM1_PCLK]
#IRCAM2_PCLK
set_property PACKAGE_PIN E23 [get_ports IRCAM2_PCLK]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM2_PCLK]
#IRCAM3_PCLK
set_property PACKAGE_PIN G21 [get_ports IRCAM3_PCLK]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM3_PCLK]
#IRCAM4_PCLK
set_property PACKAGE_PIN AM15 [get_ports IRCAM4_PCLK]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM4_PCLK]
#IRCAM5_PCLK
set_property PACKAGE_PIN AR14 [get_ports IRCAM5_PCLK]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM5_PCLK]



create_clock -period 10.000 -name IRCAM0_PCLK [get_ports IRCAM0_PCLK]

# bank 64
#NET "IRCAM0_PCLK"	LOC = AN18
#NET "IRCAM1_PCLK"	LOC = AN21

#NET "IRCAM0_HSYNC"	LOC = AR19
#NET "IRCAM0_VSYNC"	LOC = AP19
#NET "IRCAM0_DOUT[0]"	LOC = AR18
#NET "IRCAM0_DOUT[1]"	LOC = AR17
#NET "IRCAM0_DOUT[2]"	LOC = AN17
#NET "IRCAM0_DOUT[3]"	LOC = AH17
#NET "IRCAM0_DOUT[4]"	LOC = AH21
#NET "IRCAM0_DOUT[5]"	LOC = AJ21
#NET "IRCAM0_DOUT[6]"	LOC = AL19
#NET "IRCAM0_DOUT[7]"	LOC = AM19
#NET "IRCAM0_DOUT[8]"	LOC = AJ20
#NET "IRCAM0_DOUT[9];	LOC = AJ19
#NET "IRCAM0_DOUT[10]"	LOC = AK19
#NET "IRCAM0_DOUT[11]"	LOC = AK18
#NET "IRCAM0_DOUT[12]"	LOC = AH18
#NET "IRCAM0_DOUT[13]"	LOC = AJ18
#NET "IRCAM0_DOUT[14]"	LOC = AM18
#NET "IRCAM0_DOUT[15]"	LOC = AM17
#NET "IRCAM0_GENLOCK"	LOC = AT17
#NET "IRCAM1_GENLOCK"	LOC = AR21
#set_property PACKAGE_PIN AN18 [get_ports IRCAM0_PCLK]
#set_property IOSTANDARD LVCMOS18 [get_ports IRCAM0_PCLK]
set_property PACKAGE_PIN AR19 [get_ports IRCAM0_HSYNC]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM0_HSYNC]
set_property PACKAGE_PIN AP19 [get_ports IRCAM0_VSYNC]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM0_VSYNC]
set_property PACKAGE_PIN AR18 [get_ports {IRCAM0_DOUT[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM0_DOUT[0]}]
set_property PACKAGE_PIN AR17 [get_ports {IRCAM0_DOUT[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM0_DOUT[1]}]
set_property PACKAGE_PIN AN17 [get_ports {IRCAM0_DOUT[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM0_DOUT[2]}]
set_property PACKAGE_PIN AH17 [get_ports {IRCAM0_DOUT[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM0_DOUT[3]}]
set_property PACKAGE_PIN AH21 [get_ports {IRCAM0_DOUT[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM0_DOUT[4]}]
set_property PACKAGE_PIN AJ21 [get_ports {IRCAM0_DOUT[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM0_DOUT[5]}]
set_property PACKAGE_PIN AL19 [get_ports {IRCAM0_DOUT[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM0_DOUT[6]}]
set_property PACKAGE_PIN AM19 [get_ports {IRCAM0_DOUT[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM0_DOUT[7]}]
set_property PACKAGE_PIN AJ20 [get_ports {IRCAM0_DOUT[8]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM0_DOUT[8]}]
set_property PACKAGE_PIN AJ19 [get_ports {IRCAM0_DOUT[9]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM0_DOUT[9]}]
set_property PACKAGE_PIN AK19 [get_ports {IRCAM0_DOUT[10]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM0_DOUT[10]}]
set_property PACKAGE_PIN AK18 [get_ports {IRCAM0_DOUT[11]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM0_DOUT[11]}]
set_property PACKAGE_PIN AH18 [get_ports {IRCAM0_DOUT[12]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM0_DOUT[12]}]
set_property PACKAGE_PIN AJ18 [get_ports {IRCAM0_DOUT[13]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM0_DOUT[13]}]
set_property PACKAGE_PIN AM18 [get_ports {IRCAM0_DOUT[14]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM0_DOUT[14]}]
set_property PACKAGE_PIN AM17 [get_ports {IRCAM0_DOUT[15]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM0_DOUT[15]}]

#SET IR_CAM1
set_property PACKAGE_PIN AL21 [get_ports IRCAM1_HSYNC]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM1_HSYNC]
set_property PACKAGE_PIN AK21 [get_ports IRCAM1_VSYNC]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM1_VSYNC]
set_property PACKAGE_PIN AU22 [get_ports {IRCAM1_DOUT[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM1_DOUT[0]}]
set_property PACKAGE_PIN AV22 [get_ports {IRCAM1_DOUT[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM1_DOUT[1]}]
set_property PACKAGE_PIN AU20 [get_ports {IRCAM1_DOUT[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM1_DOUT[2]}]
set_property PACKAGE_PIN AV20 [get_ports {IRCAM1_DOUT[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM1_DOUT[3]}]
set_property PACKAGE_PIN AV21 [get_ports {IRCAM1_DOUT[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM1_DOUT[4]}]
set_property PACKAGE_PIN AW21 [get_ports {IRCAM1_DOUT[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM1_DOUT[5]}]
set_property PACKAGE_PIN AW20 [get_ports {IRCAM1_DOUT[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM1_DOUT[6]}]
set_property PACKAGE_PIN AW19 [get_ports {IRCAM1_DOUT[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM1_DOUT[7]}]
set_property PACKAGE_PIN AT22 [get_ports {IRCAM1_DOUT[8]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM1_DOUT[8]}]
set_property PACKAGE_PIN AT21 [get_ports {IRCAM1_DOUT[9]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM1_DOUT[9]}]
set_property PACKAGE_PIN AV18 [get_ports {IRCAM1_DOUT[10]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM1_DOUT[10]}]
set_property PACKAGE_PIN AW18 [get_ports {IRCAM1_DOUT[11]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM1_DOUT[11]}]
set_property PACKAGE_PIN AV17 [get_ports {IRCAM1_DOUT[12]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM1_DOUT[12]}]
set_property PACKAGE_PIN AN22 [get_ports {IRCAM1_DOUT[13]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM1_DOUT[13]}]
set_property PACKAGE_PIN AR22 [get_ports {IRCAM1_DOUT[14]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM1_DOUT[14]}]
set_property PACKAGE_PIN AN20 [get_ports {IRCAM1_DOUT[15]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM1_DOUT[15]}]


#SET IR_CAM2
set_property PACKAGE_PIN F24 [get_ports IRCAM2_HSYNC]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM2_HSYNC]
set_property PACKAGE_PIN F23 [get_ports IRCAM2_VSYNC]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM2_VSYNC]
set_property PACKAGE_PIN E20 [get_ports {IRCAM2_DOUT[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM2_DOUT[0]}]
set_property PACKAGE_PIN D20 [get_ports {IRCAM2_DOUT[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM2_DOUT[1]}]
set_property PACKAGE_PIN C25 [get_ports {IRCAM2_DOUT[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM2_DOUT[2]}]
set_property PACKAGE_PIN C24 [get_ports {IRCAM2_DOUT[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM2_DOUT[3]}]
set_property PACKAGE_PIN C22 [get_ports {IRCAM2_DOUT[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM2_DOUT[4]}]
set_property PACKAGE_PIN C23 [get_ports {IRCAM2_DOUT[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM2_DOUT[5]}]
set_property PACKAGE_PIN C20 [get_ports {IRCAM2_DOUT[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM2_DOUT[6]}]
set_property PACKAGE_PIN B20 [get_ports {IRCAM2_DOUT[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM2_DOUT[7]}]
set_property PACKAGE_PIN B21 [get_ports {IRCAM2_DOUT[8]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM2_DOUT[8]}]
set_property PACKAGE_PIN A21 [get_ports {IRCAM2_DOUT[9]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM2_DOUT[9]}]
set_property PACKAGE_PIN B22 [get_ports {IRCAM2_DOUT[10]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM2_DOUT[10]}]
set_property PACKAGE_PIN A22 [get_ports {IRCAM2_DOUT[11]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM2_DOUT[11]}]
set_property PACKAGE_PIN B24 [get_ports {IRCAM2_DOUT[12]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM2_DOUT[12]}]
set_property PACKAGE_PIN B25 [get_ports {IRCAM2_DOUT[13]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM2_DOUT[13]}]
set_property PACKAGE_PIN A23 [get_ports {IRCAM2_DOUT[14]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM2_DOUT[14]}]
set_property PACKAGE_PIN A24 [get_ports {IRCAM2_DOUT[15]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM2_DOUT[15]}]


#SET IR_CAM3
set_property PACKAGE_PIN G20 [get_ports IRCAM3_HSYNC]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM3_HSYNC]
set_property PACKAGE_PIN H20 [get_ports IRCAM3_VSYNC]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM3_VSYNC]
set_property PACKAGE_PIN M21 [get_ports {IRCAM3_DOUT[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM3_DOUT[0]}]
set_property PACKAGE_PIN M22 [get_ports {IRCAM3_DOUT[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM3_DOUT[1]}]
set_property PACKAGE_PIN M19 [get_ports {IRCAM3_DOUT[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM3_DOUT[2]}]
set_property PACKAGE_PIN M20 [get_ports {IRCAM3_DOUT[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM3_DOUT[3]}]
set_property PACKAGE_PIN L23 [get_ports {IRCAM3_DOUT[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM3_DOUT[4]}]
set_property PACKAGE_PIN L24 [get_ports {IRCAM3_DOUT[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM3_DOUT[5]}]
set_property PACKAGE_PIN L21 [get_ports {IRCAM3_DOUT[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM3_DOUT[6]}]
set_property PACKAGE_PIN L22 [get_ports {IRCAM3_DOUT[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM3_DOUT[7]}]
set_property PACKAGE_PIN K23 [get_ports {IRCAM3_DOUT[8]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM3_DOUT[8]}]
set_property PACKAGE_PIN K24 [get_ports {IRCAM3_DOUT[9]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM3_DOUT[9]}]
set_property PACKAGE_PIN K20 [get_ports {IRCAM3_DOUT[10]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM3_DOUT[10]}]
set_property PACKAGE_PIN K21 [get_ports {IRCAM3_DOUT[11]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM3_DOUT[11]}]
set_property PACKAGE_PIN J23 [get_ports {IRCAM3_DOUT[12]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM3_DOUT[12]}]
set_property PACKAGE_PIN H23 [get_ports {IRCAM3_DOUT[13]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM3_DOUT[13]}]
set_property PACKAGE_PIN J22 [get_ports {IRCAM3_DOUT[14]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM3_DOUT[14]}]
set_property PACKAGE_PIN F21 [get_ports {IRCAM3_DOUT[15]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM3_DOUT[15]}]



#SET IR_CAM4
set_property PACKAGE_PIN AL14 [get_ports IRCAM4_HSYNC]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM4_HSYNC]
set_property PACKAGE_PIN AL15 [get_ports IRCAM4_VSYNC]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM4_VSYNC]
set_property PACKAGE_PIN AK16 [get_ports {IRCAM4_DOUT[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM4_DOUT[0]}]
set_property PACKAGE_PIN AL16 [get_ports {IRCAM4_DOUT[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM4_DOUT[1]}]
set_property PACKAGE_PIN AN16 [get_ports {IRCAM4_DOUT[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM4_DOUT[2]}]
set_property PACKAGE_PIN AP10 [get_ports {IRCAM4_DOUT[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM4_DOUT[3]}]
set_property PACKAGE_PIN AT12 [get_ports {IRCAM4_DOUT[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM4_DOUT[4]}]
set_property PACKAGE_PIN AT11 [get_ports {IRCAM4_DOUT[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM4_DOUT[5]}]
set_property PACKAGE_PIN AN13 [get_ports {IRCAM4_DOUT[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM4_DOUT[6]}]
set_property PACKAGE_PIN AP13 [get_ports {IRCAM4_DOUT[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM4_DOUT[7]}]
set_property PACKAGE_PIN AR13 [get_ports {IRCAM4_DOUT[8]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM4_DOUT[8]}]
set_property PACKAGE_PIN AR12 [get_ports {IRCAM4_DOUT[9]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM4_DOUT[9]}]
set_property PACKAGE_PIN AM12 [get_ports {IRCAM4_DOUT[10]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM4_DOUT[10]}]
set_property PACKAGE_PIN AN12 [get_ports {IRCAM4_DOUT[11]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM4_DOUT[11]}]
set_property PACKAGE_PIN AP11 [get_ports {IRCAM4_DOUT[12]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM4_DOUT[12]}]
set_property PACKAGE_PIN AR11 [get_ports {IRCAM4_DOUT[13]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM4_DOUT[13]}]
set_property PACKAGE_PIN AM14 [get_ports {IRCAM4_DOUT[14]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM4_DOUT[14]}]
set_property PACKAGE_PIN AM13 [get_ports {IRCAM4_DOUT[15]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM4_DOUT[15]}]


# SET IR_CAM5
set_property PACKAGE_PIN AR16 [get_ports IRCAM5_HSYNC]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM5_HSYNC]
set_property PACKAGE_PIN AP16 [get_ports IRCAM5_VSYNC]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM5_VSYNC]
set_property PACKAGE_PIN AW11 [get_ports {IRCAM5_DOUT[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM5_DOUT[0]}]
set_property PACKAGE_PIN AW10 [get_ports {IRCAM5_DOUT[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM5_DOUT[1]}]
set_property PACKAGE_PIN AU12 [get_ports {IRCAM5_DOUT[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM5_DOUT[2]}]
set_property PACKAGE_PIN AV11 [get_ports {IRCAM5_DOUT[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM5_DOUT[3]}]
set_property PACKAGE_PIN AW14 [get_ports {IRCAM5_DOUT[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM5_DOUT[4]}]
set_property PACKAGE_PIN AW13 [get_ports {IRCAM5_DOUT[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM5_DOUT[5]}]
set_property PACKAGE_PIN AU10 [get_ports {IRCAM5_DOUT[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM5_DOUT[6]}]
set_property PACKAGE_PIN AV10 [get_ports {IRCAM5_DOUT[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM5_DOUT[7]}]
set_property PACKAGE_PIN AV13 [get_ports {IRCAM5_DOUT[8]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM5_DOUT[8]}]
set_property PACKAGE_PIN AV12 [get_ports {IRCAM5_DOUT[9]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM5_DOUT[9]}]
set_property PACKAGE_PIN AU14 [get_ports {IRCAM5_DOUT[10]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM5_DOUT[10]}]
set_property PACKAGE_PIN AU13 [get_ports {IRCAM5_DOUT[11]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM5_DOUT[11]}]
set_property PACKAGE_PIN AT10 [get_ports {IRCAM5_DOUT[12]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM5_DOUT[12]}]
set_property PACKAGE_PIN AT16 [get_ports {IRCAM5_DOUT[13]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM5_DOUT[13]}]
set_property PACKAGE_PIN AV16 [get_ports {IRCAM5_DOUT[14]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM5_DOUT[14]}]
set_property PACKAGE_PIN AT14 [get_ports {IRCAM5_DOUT[15]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IRCAM5_DOUT[15]}]


#IRCAM0_GENLOCK
set_property PACKAGE_PIN AT17 [get_ports IRCAM0_GENLOCK]
#IRCAM1_GENLOCK
#set_property PACKAGE_PIN AR21 [get_ports IRCAM0_GENLOCK]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM0_GENLOCK]

set_property PACKAGE_PIN AR21 [get_ports IRCAM1_GENLOCK]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM1_GENLOCK]

set_property PACKAGE_PIN D22 [get_ports IRCAM2_GENLOCK]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM2_GENLOCK]

set_property PACKAGE_PIN H22 [get_ports IRCAM3_GENLOCK]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM3_GENLOCK]

set_property PACKAGE_PIN AK17 [get_ports IRCAM4_GENLOCK]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM4_GENLOCK]

set_property PACKAGE_PIN AW16 [get_ports IRCAM5_GENLOCK]
set_property IOSTANDARD LVCMOS18 [get_ports IRCAM5_GENLOCK]


############################################################
#NET "STROBE_OUT0"	LOC = C4
set_property PACKAGE_PIN C4 [get_ports STROBE_OUT0]
set_property IOSTANDARD LVCMOS33 [get_ports STROBE_OUT0]
############################################################
#NET "CAM0_PCLK"	LOC = C5
set_property PACKAGE_PIN C5 [get_ports CAM0_PCLK]
set_property IOSTANDARD LVCMOS33 [get_ports CAM0_PCLK]
#create_clock -period 13.468 -name CAM0_PCLK [get_ports CAM0_PCLK]
create_clock -period 10.000 -name CAM0_PCLK [get_ports CAM0_PCLK]
############################################################


#####################################################################
#DEbug port (bank 71)	J26 CON IEG0(LVCMOS18)
#####################################################################

#NET "IEG0_HSYNC"	LOC = H15
#NET "IEG0_VSYNC"	LOC = J15
#NET "IEG0_PCLK"	LOC = G19
#NET "IEG0_DOUT[0]"	LOC = E18
#NET "IEG0_DOUT[1]"	LOC = E19
#NET "IEG0_DOUT[2]"	LOC = F16
#NET "IEG0_DOUT[3]"	LOC = H19
#NET "IEG0_DOUT[4]"	LOC = G16
#NET "IEG0_DOUT[5]"	LOC = G17
#NET "IEG0_DOUT[6]"	LOC = G15
#NET "IEG0_DOUT[7]"	LOC = G14
#NET "IEG0_DOUT[8]"	LOC = H14
#NET "IEG0_DOUT[9]"	LOC = H17
#NET "IEG0_DOUT[10]"	LOC = H18
#NET "IEG0_DOUT[11]"	LOC = J18
#NET "IEG0_DOUT[12]"	LOC = J17
#NET "IEG0_DOUT[13]"	LOC = K14
#NET "IEG0_DOUT[14]"	LOC = K15
#NET "IEG0_DOUT[15]"	LOC = J16
#NET "IEG0_DOUT[16]"	LOC = L16
#NET "IEG0_DOUT[17]"	LOC = L17
#NET "IEG0_DOUT[18]"	LOC = K18
#NET "IEG0_DOUT[19]"	LOC = L18
set_property PACKAGE_PIN H15 [get_ports IEG0_HSYNC]
set_property IOSTANDARD LVCMOS18 [get_ports IEG0_HSYNC]
set_property PACKAGE_PIN J15 [get_ports IEG0_VSYNC]
set_property IOSTANDARD LVCMOS18 [get_ports IEG0_VSYNC]
set_property PACKAGE_PIN G19 [get_ports IEG0_PCLK]
set_property IOSTANDARD LVCMOS18 [get_ports IEG0_PCLK]
set_property PACKAGE_PIN E18 [get_ports {IEG0_DOUT[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[0]}]
set_property PACKAGE_PIN E19 [get_ports {IEG0_DOUT[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[1]}]
set_property PACKAGE_PIN F16 [get_ports {IEG0_DOUT[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[2]}]
set_property PACKAGE_PIN H19 [get_ports {IEG0_DOUT[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[3]}]
set_property PACKAGE_PIN G16 [get_ports {IEG0_DOUT[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[4]}]
set_property PACKAGE_PIN G17 [get_ports {IEG0_DOUT[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[5]}]
set_property PACKAGE_PIN G15 [get_ports {IEG0_DOUT[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[6]}]
set_property PACKAGE_PIN G14 [get_ports {IEG0_DOUT[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[7]}]
set_property PACKAGE_PIN H14 [get_ports {IEG0_DOUT[8]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[8]}]
set_property PACKAGE_PIN H17 [get_ports {IEG0_DOUT[9]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[9]}]
###########################################################
set_property PACKAGE_PIN H18 [get_ports {IEG0_DOUT[10]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[10]}]
set_property PACKAGE_PIN J18 [get_ports {IEG0_DOUT[11]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[11]}]
set_property PACKAGE_PIN J17 [get_ports {IEG0_DOUT[12]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[12]}]
set_property PACKAGE_PIN K14 [get_ports {IEG0_DOUT[13]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[13]}]
set_property PACKAGE_PIN K15 [get_ports {IEG0_DOUT[14]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[14]}]
set_property PACKAGE_PIN J16 [get_ports {IEG0_DOUT[15]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[15]}]
set_property PACKAGE_PIN L16 [get_ports {IEG0_DOUT[16]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[16]}]
set_property PACKAGE_PIN L17 [get_ports {IEG0_DOUT[17]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[17]}]
set_property PACKAGE_PIN K18 [get_ports {IEG0_DOUT[18]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[18]}]
set_property PACKAGE_PIN L18 [get_ports {IEG0_DOUT[19]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG0_DOUT[19]}]
###########################################################

#####################################
#DEBUG port2 (bank 64 & 70) J30 connector   IEG1 LVCMOS18
#####################################
#NET "IEG1_HSYNC"	LOC = AL20
#NET "IEG1_VSYNC"	LOC = AM20
#NET "IEG1_PCLK"	LOC = AP18

#NET "IEG1_DOUT[0]"	LOC = AU18
#NET "IEG1_DOUT[1]"	LOC = AU19
#NET "IEG1_DOUT[2]"	LOC = AU17
#NET "IEG1_DOUT[3]"	LOC = AT19
#NET "IEG1_DOUT[4]"	LOC = AT20
#NET "IEG1_DOUT[5]"	LOC = AP20
#NET "IEG1_DOUT[6]"	LOC = AP21
#NET "IEG1_DOUT[7]"	LOC = AM22
#NET "IEG1_DOUT[8]"	LOC = AL22
#NET "IEG1_DOUT[9]"	LOC = D21
#NET "IEG1_DOUT[10]"	LOC = E21
#NET "IEG1_DOUT[11]"	LOC = D23
#NET "IEG1_DOUT[12]"	LOC = D25
#NET "IEG1_DOUT[13]"	LOC = E25
#NET "IEG1_DOUT[14]"	LOC = E24
#NET "IEG1_DOUT[15]"	LOC = F22
#NET "IEG1_DOUT[16]"	LOC = G22
#NET "IEG1_DOUT[17]"	LOC = G24
#NET "IEG1_DOUT[18]"	LOC = H24
#NET "IEG1_DOUT[19]"	LOC = J21
set_property PACKAGE_PIN AL20 [get_ports IEG1_HSYNC]
set_property IOSTANDARD LVCMOS18 [get_ports IEG1_HSYNC]
set_property PACKAGE_PIN AM20 [get_ports IEG1_VSYNC]
set_property IOSTANDARD LVCMOS18 [get_ports IEG1_VSYNC]
set_property PACKAGE_PIN AP18 [get_ports IEG1_PCLK]
set_property IOSTANDARD LVCMOS18 [get_ports IEG1_PCLK]
set_property PACKAGE_PIN AU18 [get_ports {IEG1_DOUT[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[0]}]
set_property PACKAGE_PIN AU19 [get_ports {IEG1_DOUT[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[1]}]
set_property PACKAGE_PIN AU17 [get_ports {IEG1_DOUT[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[2]}]
set_property PACKAGE_PIN AT19 [get_ports {IEG1_DOUT[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[3]}]
set_property PACKAGE_PIN AT20 [get_ports {IEG1_DOUT[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[4]}]
set_property PACKAGE_PIN AP20 [get_ports {IEG1_DOUT[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[5]}]
set_property PACKAGE_PIN AP21 [get_ports {IEG1_DOUT[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[6]}]
set_property PACKAGE_PIN AM22 [get_ports {IEG1_DOUT[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[7]}]
set_property PACKAGE_PIN AL22 [get_ports {IEG1_DOUT[8]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[8]}]
set_property PACKAGE_PIN D21 [get_ports {IEG1_DOUT[9]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[9]}]
set_property PACKAGE_PIN E21 [get_ports {IEG1_DOUT[10]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[10]}]
set_property PACKAGE_PIN D23 [get_ports {IEG1_DOUT[11]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[11]}]
set_property PACKAGE_PIN D25 [get_ports {IEG1_DOUT[12]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[12]}]
set_property PACKAGE_PIN E25 [get_ports {IEG1_DOUT[13]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[13]}]
set_property PACKAGE_PIN E24 [get_ports {IEG1_DOUT[14]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[14]}]
set_property PACKAGE_PIN F22 [get_ports {IEG1_DOUT[15]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[15]}]
set_property PACKAGE_PIN G22 [get_ports {IEG1_DOUT[16]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[16]}]
set_property PACKAGE_PIN G24 [get_ports {IEG1_DOUT[17]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[17]}]
set_property PACKAGE_PIN H24 [get_ports {IEG1_DOUT[18]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[18]}]
set_property PACKAGE_PIN J21 [get_ports {IEG1_DOUT[19]}]
set_property IOSTANDARD LVCMOS18 [get_ports {IEG1_DOUT[19]}]
##############################################################

set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.D00_MOSI PULLNONE [current_design]
set_property BITSTREAM.CONFIG.D01_DIN PULLNONE [current_design]
set_property BITSTREAM.CONFIG.M2PIN PULLDOWN [current_design]

# I2C (FPGA slave) pins (same as EO project wiring)
set_property PACKAGE_PIN G11 [get_ports SCL]
set_property IOSTANDARD LVCMOS33 [get_ports SCL]
set_property PULLUP true [get_ports SCL]
set_property PACKAGE_PIN F11 [get_ports SDA]
set_property IOSTANDARD LVCMOS33 [get_ports SDA]
set_property PULLUP true [get_ports SDA]
