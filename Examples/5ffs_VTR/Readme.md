This example represent a delay line for input signal. 
This is basically cascaded flipflops
- flipflop_tb_vtr.v : a testbench for verilog flipflop file
- flipflop.v        : the core of the example
- RisingEdge_DFlipFlop_AsyncResetHigh_post_synthesis.sdf : the associated propagation delays for singals in the netlist
- RisingEdge_DFlipFlop_AsyncResetHigh_post_synthesis.v   : the netlist representing the FPGA schematics in verilog

These data were collected using VTR flow.