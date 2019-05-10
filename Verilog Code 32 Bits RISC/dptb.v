`timescale 1ns / 1ps
module dataPath_tb;

reg reset;

DataPath DUT (reset);

always
    begin
    reset = 1;
    #5
    reset = 0;
    #250
    
    $display("Finished");
    $stop;
    end
endmodule
