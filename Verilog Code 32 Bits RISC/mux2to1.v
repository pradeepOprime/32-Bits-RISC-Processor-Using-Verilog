`timescale 1ns / 1ps

module mux2to1(
    output reg[31:0] Data,
    input [31:0] D0, D1,
    input sel
    );
    always@(*)
    Data = sel ? D1 : D0;
endmodule
