`timescale 1ns / 1ps

module ALU(
    output reg [31:0] DOut,
    input [31:0] Drs1,
    input [31:0] Drs2,
    input [31:0] Dimm,
    input [23:0] Opc
    );
    always@(*)
    case(Opc)
    24'b000000000000000000000001: DOut <= Drs1 + Drs2;              // nop and add
    24'b000000000000000000000010: DOut <= Drs1 - Drs2;              // sub
    24'b000000000000000000000100: DOut <= Drs2 + Dimm;              // store
    24'b000000000000000000001000: DOut <= Drs1 + Dimm;              // load
    24'b000000000000000000100000: DOut <= (Drs1 >= Drs2) ? 1 : 0;   // sge
    24'b000000000000000001000000: DOut <= (Drs1 <= Drs2) ? 1 : 0;   // sle
    24'b000000000000000010000000: DOut <= (Drs1 > Drs2) ? 1 : 0;    // sgt
    24'b000000000000000100000000: DOut <= (Drs1 < Drs2) ? 1 : 0;    // slt
    24'b000000000000001000000000: DOut <= (Drs1 == Drs2) ? 1 : 0;   // seq
    24'b000000000000010000000000: DOut <= (Drs1 != Drs2) ? 1 : 0;   //sne
    24'b000000000000100000000000: DOut <= Drs1 & Drs2;              // and
    24'b000000000001000000000000: DOut <= Drs1 | Drs2;              // or
    24'b000000000010000000000000: DOut <= Drs1 ^ Drs2;              // xor
    24'b000000000100000000000000: DOut <= ~Drs1;                    // not
    24'b000000010000000000000000: DOut <= Drs1 << Dimm;             // sli
    24'b000000100000000000000000: DOut <= Drs1 >>> Dimm;            // sri
    24'b000001000000000000000000: DOut <= Drs1 + Dimm;              // addi
    24'b000010000000000000000000: DOut <= Drs1 - Dimm;              // subi
    endcase
endmodule
