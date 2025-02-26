
module LUT(I1,I2,I3,I4,O1);
    input I1,I2,I3,I4;            // Data input
    output O1;       // output Q

//simple flipflop example
    always @(I1 , I2 , I3 , I4 )
        begin
             O1<= I1 & I2 & I3 & I4; //simple reduce AND 
        end

endmodule
