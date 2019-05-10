`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2017 12:57:51 PM
// Design Name: 
// Module Name: multsign
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module multsign(
input sign1, sign2,
output reg signout
    );

always @ (*)
begin
    signout = sign1 ^ sign2;
end    
endmodule
