`timescale 1ns / 1ps

module normalmult(
input [24:0] in,
input [5:0] shift,
output reg [22:0] frac,
output reg [5:0] expchange
    );

always @ (*)
    begin
        frac = (in[0]) ? (in[23:1] + 1) : in[23:1];
        expchange = 47 - shift;
    end
endmodule
