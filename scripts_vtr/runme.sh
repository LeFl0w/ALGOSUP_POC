#select the right install path for VTR binaries
export VTR_BIN_PATH=/home/flo/FLORENT/GIT/vtr-verilog-to-routing/build/bin/

#add to path
export PATH=$VTR_BIN_PATH:$PATH

#create work directory
mkdir -p work
cd work

#synthesis with yosys using vtr plugin parmys
yosys -c ../scripts_vtr/synthesis.tcl


#create timing with vpr
vpr ../src/simple-7series.xml flipflop.parmys.blif --gen_post_synthesis_netlist on  --post_synth_netlist_unconn_inputs gnd

#you can add this option to see GUI
#--disp on
# a full description of GUI is available at https://docs.verilogtorouting.org/en/latest/vpr/graphics/


