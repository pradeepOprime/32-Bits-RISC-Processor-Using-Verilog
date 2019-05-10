`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2017 10:55:54 AM
// Design Name: 
// Module Name: Shifter_test
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


module Shifter_test;
    reg [31:0] D1, D2;
    reg sli, sri;
    wire [31:0] DOut;
    Shifter shifter (.DOut(DOut),
                     .D1(D1),
                     .D2(D2),
                     .SLI(sli),
                     .SRI(sri));
    initial
    begin
        D1 = 1; D2 = 1; sli = 0; sri = 0;
    #2                  sli = 1; sri = 0;
    #2                  sli = 0; sri = 1;
    #2  D1 = -2;
    end
endmodule
