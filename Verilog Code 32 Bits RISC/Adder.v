`timescale 1ns / 1ps

module Adder(
    output reg [31:0] DOut,
    input [31:0] D1,
    input [31:0] D2,
    input cin
    );
    always@(*)
    begin
     DOut <= D1 + D2 + cin; 
    end
endmodule
