`timescale 1ns / 1ps

module normmultexp(
input [8:0] num1,
input [5:0] num2,
output reg [8:0] out
    );

always @ (*)
    begin
        if (num2[5])
            begin
                out = num1 + 1;
            end
        else
            begin
                out = num1 - {3'b000, num2};
            end    
    end    
endmodule
