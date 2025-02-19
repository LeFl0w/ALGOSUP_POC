#generate verilog timed netlist
icetime -o TimeNetlist.v -d lp8k  ./output.asc 

##additionnal interesting command to report longest net path topological propagation timing
#icetime  -d lp8k  -t ./output.asc