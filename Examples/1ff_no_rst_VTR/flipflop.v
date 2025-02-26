
module FF1_norst(D,clk,Q);
    input D;            // Data input
    input clk;          // clock input
    output reg Q;       // output Q

//simple flipflop example
    always @(posedge clk )
        begin
             Q <= D;
        end

endmodule
