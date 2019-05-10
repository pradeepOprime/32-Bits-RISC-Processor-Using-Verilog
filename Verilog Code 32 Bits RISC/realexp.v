`timescale 1ns / 1ps

module realexp(
input [8:0] in,
output reg [8:0] out);

always @(*)
begin
    out = in - 127;
end
endmodule
