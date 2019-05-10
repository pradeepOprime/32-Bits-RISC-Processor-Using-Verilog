`timescale 1ns / 1ps

module floatfractest;

reg [31:0] num, num2;
wire [31:0] test;

floatingmultiplier TEST (num, num2, test);

always
    begin
    #5
    num = 32'hbe800000;
    num2 = 32'hbe700000;
    end

endmodule
