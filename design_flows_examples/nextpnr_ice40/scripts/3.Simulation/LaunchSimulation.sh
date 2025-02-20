#rucompilen verilog simulation 

#IF you want to perform functional simulation use following line
#iverilog -o designDB src/flipflop_tb.v src/flipflop.v

#IF you want to perform post place and route simulation (with real timing propagation delay
#use the following line
iverilog -g 2012 -o designDB src/flipflop_tb.v src/yosysLib/cells_sim.v TimeNetlist.v

#run the simulation and dump the data
vvp designDB