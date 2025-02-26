
module FF1(D,clk,async_reset,Q);
    input D;            // Data input
    input clk;          // clock input
    input async_reset;  // asynchronous reset high level
    output reg Q;       // output Q
   

//simple flipflop example
    always @(posedge clk or posedge async_reset)
        begin
            if(async_reset==1'b1)
                 Q1 <= 1'b0;
            else
        Q <= D;
    end


endmodule
