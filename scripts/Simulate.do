####Compile library NX for real timings####
#this library is encrypted and can only be decoded by siemens modelsim or questa software
vlib nx
vcom -work nx -2008 "../src/NanoXplore/nxLibrary-Ultra300.vhdp"
vlog -work nx ../src/NanoXplore/nxInclude-Ultra300.v

#compile application to be simulated (need  project P&R first)
vlib work
vlog ../routed_POC.v
#compile testbench
vlog ../../src/flipflop_tb.v

#launch simulation
sim work.flipflop_tb -L nx -sdftyp /dut/=../../Project/routed_POC_typical.sdf

#add waves
add wave sim:/flipflop_tb/*
add wave sim:/flipflop_tb/dut/*



#compile application to be simulated (need  project P&R first)
vlib work
vcom -work work -explicit  -2008 ../Project/routed_POC.vhd
#compile testbench
vcom -work work -explicit  -2008 "../src/flipflop_tb.v"

#launch simulation
vsim -t 1ps -lib work work.flipflop_tb -sdfmax dut=../Project/routed_POC_typical.sdf

