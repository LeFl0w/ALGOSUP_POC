#Enable command logging
transcript on

#Setup working directories
if {[file exists gate_work]} {
    vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

#Load the verilog files
vlog -sv -work work {../multiclock_post_synthesis.v}
vlog -sv -work work {../testbench.v}
vlog -sv -work gate_work {../../src/primitives.v}

#Setup the simulation
vsim -t 1ps -L gate_work -L work -voptargs="+acc" +sdf_verbose +bitblast tb

#Log signal changes to a VCD file
vcd file sim.vcd
vcd add /tb/dut/*
vcd add /tb/dut/*

#Setup the waveform viewer
log -r /tb/*
add wave /tb/*
view structure
view signals

#Run the simulation for 1 microsecond
run 1us -all