`timescale 1ns / 1ps

module addexp(
input [8:0] in1, in2,
output reg [8:0] out
    );
    
always @ (*)
begin
    out = in1 + in2;
end    
endmodule
