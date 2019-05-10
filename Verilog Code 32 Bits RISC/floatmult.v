`timescale 1ns / 1ps

module fracmult(
input [23:0] num1, num2,
output reg [47:0] product
    );

always @ (*)
    begin
        product = num1 * num2;
    end    
endmodule
