`timescale 1ns / 1ps

module fmtocpu(
input [31:0]in,
input invalid,
output reg [31:0] product
    );

always @ (*)
begin
    product = (invalid) ? 32'b1 : in;
end    
endmodule
