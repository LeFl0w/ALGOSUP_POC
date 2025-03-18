
module FF1(D,clk,reset,Q);
    input D;            // Data input
    input clk;          // clock input
    input reset;  // asynchronous reset high level
    output reg Q;       // output Q
   

//simple flipflop example
    always @(posedge clk)
        begin
            if(reset==1'b1)
                 Q <= 1'b0;
            else
        Q <= D;
    end


endmodule
