`timescale 1ns / 1ps

module floatcmp(
input [31:0] num1, num2,
output reg sign, s,
output reg [7:0] dexp);

always @ (*)
    begin
        s = (num2[30:0] > num1[30:0]);
        sign = (num2[30:0]>num1[30:0]) ? num2[31] : num1[31];
        dexp = (s) ? (num2[30:23]-num1[30:23]) : (num1[30:23]-num2[30:23]);
    end
endmodule
