`timescale 1ns/1ps;


module flipflop_tb();
reg D;
reg clk;
reg reset;
wire Q;

RisingEdge_DFlipFlop_AsyncResetHigh dut(.D(D),.clk(clk),.async_reset(reset),.Q(Q));

//create stimuli for clock input
initial begin
  clk=0;
     forever #40 clk = ~clk;
end

initial begin
    //prepare dumping signal in a VcD file below flipflop_tb module
    $dumpfile("data.vcd");
    $dumpvars(0,flipflop_tb);


    //enable reset
    reset=1;
    //initialize inputs
    D <= 0;

    //wait prior to disbale reset
    #13;
    reset=0;

    //synchronize with clock rising edge
    @(posedge clk) ;
    D <= 1;
    @(posedge clk) ;
    D <= 0;
    @(posedge clk) ;
    @(posedge clk) ;
    D <= 1;

    #700 $stop;
    end

endmodule