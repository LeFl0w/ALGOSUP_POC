

module FF2(D,clk,async_reset,Q);
    input D;            // Data input
    input clk;          // clock input
    input async_reset;  // asynchronous reset high level
    output reg Q;       // output Q
   
    reg Q1; //internal flipflop

//1st flipflop
    always @(posedge clk or posedge async_reset)
        begin
            if(async_reset==1'b1)
                 Q1 <= 1'b0;
            else
        Q1 <= D;
    end

//2nd flipflop
    always @(posedge clk or posedge async_reset)
        begin
            if(async_reset==1'b1)
                 Q2 <= 1'b0;
            else
        Q <= Q1;
    end



endmodule
