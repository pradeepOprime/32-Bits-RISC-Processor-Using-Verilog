`timescale 1ns / 1ps

module floatshift(
input [23:0] in, //when instantiated, 1 will be concatenated with input
input [7:0] shift,
output reg [23:0] out
    );
    
always @(*)
    begin
        out = in >> shift;
    end    
endmodule
