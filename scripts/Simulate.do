####Compile library NX for real timings####
#this library is encrypted and can only be decoded by siemens modelsim or questa software
vlib nx
vcom -work nx -explicit -2008 "../src/NanoXplore/nxLibrary-Ultra.vhdp" 
vlog -work nx ../src/NanoXplore/nxInclude-Ultra.v

#compile application to be simulated (need project P&R first)
vlib work
vlog ../Project/routed_POC.v

#compile testbench
vlog ../src/flipflop_tb.v

#set current locaiton (sdf need absolute path)
variable currentloc [pwd]
echo "$currentloc"

#launch simulation
vsim -voptargs=+acc -t 1ps -lib work -sdfmax dut=$currentloc/../Project/routed_POC_worst.sdf work.flipflop_tb -L nx

#add waves

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {IO signals}
add wave -noupdate /flipflop_tb/clk
add wave -noupdate /flipflop_tb/D
add wave -noupdate /flipflop_tb/Q
add wave -noupdate /flipflop_tb/reset
add wave -noupdate -divider {flipflop Q2 (with Q3 signal output)}
add wave /flipflop_tb/dut/r_clk_1
add wave -noupdate /flipflop_tb/dut/Q2
add wave -noupdate /flipflop_tb/dut/Q3
add wave -noupdate -divider {flipflop Q3 (with Q4 signal output)}
add wave /flipflop_tb/dut/r_clk_1
add wave -noupdate /flipflop_tb/dut/Q3
add wave -noupdate /flipflop_tb/dut/Q4
WaveRestoreZoom {0 ps} {700 ns}

run -all
