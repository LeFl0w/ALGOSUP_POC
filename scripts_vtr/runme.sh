mkdir -p work
cd work

#synthesis with yosys using vtr plugin parmys
/home/flo/FLORENT/GIT/vtr-verilog-to-routing/build/bin/yosys -c ../scripts_vtr/synthesis.tcl



#create timing with vpr
vpr ../src/simple-7series.xml flipflop.parmys.blif --gen_post_synthesis_netlist on  --post_synth_netlist_unconn_inputs gnd
#--disp on

