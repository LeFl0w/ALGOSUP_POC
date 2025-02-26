
module FULLLUT(I1,I2,I3,I4,O1);
    input I1,I2,I3,I4;            // Data input
    output O1;       // output Q

    wire [3:0] concat_vect;


assign concat_vect = {I1,I2,I3,I4};

//simple Full LUT example
    always @(concat_vect )
        begin
            case ( concat_vect ) //determine if there is a odd number of 1 in the inputs
                4'b0000: O1<=0;
                4'b0001: O1<=1;
                4'b0010: O1<=1;
                4'b0011: O1<=0;
                4'b0100: O1<=1;
                4'b0101: O1<=0;
                4'b0110: O1<=0;
                4'b0111: O1<=1;
                4'b1000: O1<=1;
                4'b1001: O1<=0;
                4'b1010: O1<=0;
                4'b1011: O1<=1;
                4'b1100: O1<=0;
                4'b1101: O1<=1;
                4'b1110: O1<=1;
                4'b1111: O1<=0;
            endcase
        end

endmodule
