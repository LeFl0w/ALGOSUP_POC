`timescale 1ns/1ps

module tb();

localparam CLOCK_PERIOD = 40;
localparam CLOCK_DELAY = CLOCK_PERIOD / 2;

//Simulation clock
logic sim_clk;


//inputs
logic \in1 ;
logic \in2 ;
logic \in3 ;
logic \clk ;
logic \clk2 ;

//outputs
logic \out1 ;
logic \out2 ;
logic \out3 ;

//Instantiate the dut
multiclock dut ( .* );

//Load the SDF
//be careful simulation will run in SIM folder that's why we use ../
initial $sdf_annotate("../multiclock_post_synthesis.sdf", dut);

//The simulation clock
initial sim_clk = '1;
always #CLOCK_DELAY sim_clk = ~sim_clk;

//The circuit clocks
assign \clk = sim_clk;
assign \clk2 = sim_clk;

//Randomized input
always@(posedge sim_clk) begin
    \in1 <= $urandom_range(1,0);
    \in2 <= $urandom_range(1,0);
    \in3 <= $urandom_range(1,0);
end

//end simulation
initial begin

    #700 $stop;
end

endmodule