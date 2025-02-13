// FPGA projects using Verilog/ VHDL 
// fpga4student.com
// Verilog code for D Flip FLop
// Verilog code for Rising edge D flip flop with Asynchronous Reset high

module RisingEdge_DFlipFlop_AsyncResetHigh(D,clk,async_reset,Q);
    input D; // Data input
    input clk; // clock input
    input async_reset; // asynchronous reset high level
    output reg Q; // output Q

    always @(posedge clk or posedge async_reset)
        begin
            if(async_reset==1'b1)
                 Q <= 1'b0;
            else
        Q <= D;
    end
endmodule
