`timescale 1ns / 1ps

module PC_test;
    reg [31:0] jump, branch;
    reg [1:0] sel;
    reg clk, reset;
    wire [31:0] count;
    PC pc (.Count(count),
           .Jump(jump),
           .Branch(branch),
           .sel_j(sel[1]),
           .sel_b(sel[0]),
           .clk(clk),
           .reset(reset));
    initial clk = 0;
    always #1 clk = ~clk;
    initial
    begin
        reset = 0;      sel = 2'b00;
    #2  reset = ~reset;
    #8                  sel = 2'b01; jump = 32'h12345678; branch = 32'hfedcba98;
    #10                 sel = 2'b00;
    #16                 sel = 2'b10;
    #18                 sel = 2'b00;
    #24                 sel = 2'b11;
    #26                 sel = 2'b00;
    #32 reset = ~reset;
    end
endmodule
