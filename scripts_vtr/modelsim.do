#Enable command logging
transcript on

#Setup working directories
if {[file exists gate_work]} {
    vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

#Load the verilog files
vlog -sv -work work {../work/RisingEdge_DFlipFlop_AsyncResetHigh_post_synthesis.v}
vlog -sv -work work {../src/flipflop_tb_vtr.v}
vlog -sv -work gate_work {../src/primitives.v}

#Setup the simulation
vsim -t 1ps -L gate_work -L work -voptargs="+acc" +sdf_verbose +bitblast flipflop_tb -sdfmax dut=../work/RisingEdge_DFlipFlop_AsyncResetHigh_post_synthesis.sdf


#Log signal changes to a VCD file
vcd file sim.vcd
vcd add /flipflop_tb/dut/*
vcd add /flipflop_tb/dut/*

#Setup the waveform viewer
log -r /flipflop_tb/*
add wave /flipflop_tb/*
view structure
view signals

#Run the simulation for 1 microsecond
run 1us -all