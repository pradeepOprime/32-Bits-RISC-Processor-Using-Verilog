`timescale 1ns / 1ps

module realmultexp(
input [8:0] in,
output reg [8:0] out
    );
    
reg [8:0] signout;
    
always @ (*)
begin
signout = in + 127;
out = signout [7:0];
end    
endmodule
