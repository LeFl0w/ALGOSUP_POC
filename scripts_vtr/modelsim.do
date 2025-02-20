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

#Setup the waveform viewer
log -r /flipflop_tb/*

view structure
view signals

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {IO signals}
add wave -noupdate /flipflop_tb/async_reset
add wave -noupdate /flipflop_tb/clk
add wave -noupdate /flipflop_tb/D
add wave -noupdate {/flipflop_tb/dut/\latch_$sdff~0^Q~0_input_0_0 }
add wave -noupdate {/flipflop_tb/dut/\latch_$sdff~0^Q~0_clock_0_0 }
add wave -noupdate {/flipflop_tb/dut/\latch_$sdff~0^Q~0_output_0_0 }
add wave -noupdate {/flipflop_tb/dut/\latch_$sdff~1^Q~0_input_0_0 }
add wave -noupdate {/flipflop_tb/dut/\latch_$sdff~1^Q~0_clock_0_0 }
add wave -noupdate {/flipflop_tb/dut/\latch_$sdff~2^Q~0_input_0_0 }
add wave -noupdate {/flipflop_tb/dut/\latch_$sdff~2^Q~0_clock_0_0 }
add wave -noupdate {/flipflop_tb/dut/\latch_$sdff~2^Q~0_output_0_0 }
add wave -noupdate {/flipflop_tb/dut/\latch_$sdff~3^Q~0_input_0_0 }
add wave -noupdate {/flipflop_tb/dut/\latch_$sdff~3^Q~0_clock_0_0 }
add wave -noupdate {/flipflop_tb/dut/\latch_$sdff~3^Q~0_output_0_0 }
add wave -noupdate /flipflop_tb/Q
add wave -noupdate /flipflop_tb/reset
add wave -noupdate -divider {Q2 to Q3 data}
add wave -noupdate {/flipflop_tb/dut/\latch_$sdff~2^Q~0_input_0_0 }
add wave -noupdate {/flipflop_tb/dut/\latch_$sdff~2^Q~0_output_0_0 }
add wave -noupdate {/flipflop_tb/dut/\latch_$sdff~3^Q~0_input_0_0 }
add wave -noupdate -divider {Q2 to Q3 clock}
add wave -noupdate /flipflop_tb/clk
add wave -noupdate {/flipflop_tb/dut/\latch_$sdff~3^Q~0_clock_0_0 }
add wave -noupdate {/flipflop_tb/dut/\latch_$sdff~2^Q~0_clock_0_0 }
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {178154 ps} 0}
quietly wave cursor active 1
configure wave -timelineunits ps
update
WaveRestoreZoom {115257 ps} {205369 ps}

#Run the simulation for 1 microsecond
run 1us -all