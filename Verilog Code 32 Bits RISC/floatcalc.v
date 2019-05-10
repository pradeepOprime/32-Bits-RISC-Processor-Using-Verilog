`timescale 1ns / 1ps

module floatcalcadd(
input [23:0] larger, smaller,
input parity, //sign bits xor'd
output reg [24:0] sum //to handle in case of overflow
);

always @ (*)
    begin
        if (parity == 0)
            begin
            sum = larger + smaller;
            end
        else
            begin
            sum = larger - smaller;
            end    
    end
endmodule
