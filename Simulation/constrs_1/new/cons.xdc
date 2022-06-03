//reset
set_property PACKAGE_PIN R2 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

//input buttons
set_property PACKAGE_PIN W19 [get_ports {B[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {B[8]}]

set_property PACKAGE_PIN T18 [get_ports {B[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {B[7]}]

set_property PACKAGE_PIN T17 [get_ports {B[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {B[6]}]

set_property PACKAGE_PIN U17 [get_ports {B[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {B[5]}]


//mode switch
set_property PACKAGE_PIN U18 [get_ports {B[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {B[0]}]


//operations buttons
set_property PACKAGE_PIN V17 [get_ports {B[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {B[4]}]

set_property PACKAGE_PIN V16 [get_ports {B[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {B[3]}]

set_property PACKAGE_PIN W16 [get_ports {B[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {B[2]}]

set_property PACKAGE_PIN W17 [get_ports {B[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {B[1]}]


//digit anode
set_property PACKAGE_PIN W4 [get_ports ssgAnode[0]]
set_property IOSTANDARD LVCMOS33 [get_ports ssgAnode[0]]

set_property PACKAGE_PIN V4 [get_ports ssgAnode[1]]
set_property IOSTANDARD LVCMOS33 [get_ports ssgAnode[1]]

set_property PACKAGE_PIN U4 [get_ports ssgAnode[2]]
set_property IOSTANDARD LVCMOS33 [get_ports ssgAnode[2]]

set_property PACKAGE_PIN U2 [get_ports ssgAnode[3]]
set_property IOSTANDARD LVCMOS33 [get_ports ssgAnode[3]]


//seven segment
set_property PACKAGE_PIN W7 [get_ports ssg[7]]
set_property IOSTANDARD LVCMOS33 [get_ports ssg[7]]

set_property PACKAGE_PIN W6 [get_ports ssg[6]]
set_property IOSTANDARD LVCMOS33 [get_ports ssg[6]]

set_property PACKAGE_PIN U8 [get_ports ssg[5]]
set_property IOSTANDARD LVCMOS33 [get_ports ssg[5]]

set_property PACKAGE_PIN V8 [get_ports ssg[4]]
set_property IOSTANDARD LVCMOS33 [get_ports ssg[4]]

set_property PACKAGE_PIN U5 [get_ports ssg[3]]
set_property IOSTANDARD LVCMOS33 [get_ports ssg[3]]

set_property PACKAGE_PIN V5 [get_ports ssg[2]]
set_property IOSTANDARD LVCMOS33 [get_ports ssg[2]]

set_property PACKAGE_PIN U7 [get_ports ssg[1]]
set_property IOSTANDARD LVCMOS33 [get_ports ssg[1]]

set_property PACKAGE_PIN V7 [get_ports ssg[0]]
set_property IOSTANDARD LVCMOS33 [get_ports ssg[0]]

set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]