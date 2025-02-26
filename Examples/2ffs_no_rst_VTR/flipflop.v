

module FF2_norst(D,clk,Q);
    input D;            // Data input
    input clk;          // clock input
    output reg Q;       // output Q
   
    reg Q1; //internal flipflop

//1st flipflop
    always @(posedge clk )
        begin
        Q1 <= D;
    end

//2nd flipflop
    always @(posedge clk )
        begin
        Q <= Q1;
    end



endmodule
