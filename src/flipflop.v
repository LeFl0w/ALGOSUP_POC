// FPGA projects using Verilog/ VHDL 
// fpga4student.com
// Verilog code for D Flip FLop
// Verilog code for Rising edge D flip flop with Asynchronous Reset high

module RisingEdge_DFlipFlop_AsyncResetHigh(D,clk,async_reset,Q);
    input D;            // Data input
    input clk;          // clock input
    input async_reset;  // asynchronous reset high level
    output reg Q;       // output Q
   
    reg Q1,Q2,Q3,Q4; //internal fence for i_top_0

//this flip flop is there to isolate FPGA IO from internal
    always @(posedge clk or posedge async_reset)
        begin
            if(async_reset==1'b1)
                 Q1 <= 1'b0;
            else
        Q1 <= D;
    end

//**********************************************************************//
// this is the core of the example free of time propopagation from IO to 
// FPGA internal

    always @(posedge clk or posedge async_reset)
        begin
            if(async_reset==1'b1)
                 Q2 <= 1'b0;
            else
        Q2 <= Q1;
    end

    always @(posedge clk or posedge async_reset)
        begin
            if(async_reset==1'b1)
                 Q3 <= 1'b0;
            else
        Q3 <= Q2;
    end

    always @(posedge clk or posedge async_reset)
        begin
            if(async_reset==1'b1)
                 Q4 <= 1'b0;
            else
        Q4 <= Q3;
    end
//**********************************************************************//



//this flip flop is there to isolate FPGA IO from internal
    always @(posedge clk or posedge async_reset)
        begin
            if(async_reset==1'b1)
                 Q <= 1'b0;
            else
        Q <= Q4;
    end


endmodule
