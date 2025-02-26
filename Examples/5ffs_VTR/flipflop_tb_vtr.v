`timescale 1ns/1ps

module flipflop_tb();

localparam CLOCK_PERIOD = 40;
localparam CLOCK_DELAY = CLOCK_PERIOD / 2;

//Simulation clock
logic sim_clk;
//simulation reset
logic reset;

//inputs
logic \D ;
logic \clk ;
logic \async_reset ;

//outputs
logic \Q ;


//Instantiate the dut
RisingEdge_DFlipFlop_AsyncResetHigh dut ( .* );

//Load the SDF
//be careful simulation will run in SIM folder that's why we use ../
initial $sdf_annotate("../work/RisingEdge_DFlipFlop_AsyncResetHigh_post_synthesis.sdf", dut);

//The simulation clock
initial sim_clk = '1;
always #CLOCK_DELAY sim_clk = ~sim_clk;

//The circuit clocks
assign \clk = sim_clk;

//The reset
assign \async_reset = reset;

//Randomized input
always@(posedge sim_clk) begin
    \D <= $urandom_range(1,0);
end


//end simulation
initial begin
    //enable reset
    reset=1;
    
    //wait prior to disbale reset
    #13;
    reset=0;

    #700 $stop;
end

endmodule