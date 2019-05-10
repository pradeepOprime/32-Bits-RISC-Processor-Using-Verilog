`timescale 1ns / 1ps

module DataPath(input reset);
reg clk;
initial clk = 0;
always #5 clk = ~clk;

// IF
wire [31:0] D_pc;   // bus between PC and IM
wire [25:0] D_j;    // jump bus to extension
wire [23:0] opc_rf, opc_alu;
reg [31:0] D_b;    // calculated branch bus
reg sel_b;
PC pc (.Count(D_pc),    // output to IM
       .Jump({6'b0, D_j}),     // input from IM, extended 6 bit 0's
       .Branch(D_b),   // input from branch calculation
       .sel_j(opc_rf[20]),    // input from opc dec
       .sel_b(sel_b),    // input from opc dec
       .clk(clk),
       .reset(reset));
wire [31:0] D_im;   // bus between IM and InstructionRegister
IMemory im (.AIn(D_pc),    // input from PC
         .DOut(D_im));  // insert instructions    
         // output to InstructionRegister
wire [5:0] D_opc;   // bus between InstructionRegister and OPC DEC
wire [4:0] D_rs1;   // addr bus for rs1
wire [4:0] D_rs2;   // addr bus for rs2 or rd in imm
wire [4:0] D_rd;    // addr bus for rd
wire [15:0] D_ab;   // ALU or branch bus to extension
InstructionRegister ir (.OPC(D_opc),      // to OPC DEC
       .RS_RS1(D_rs1),   // to RF
       .RD_RS2(D_rs2),   // to RF
       .RD(D_rd),       // to mux then flipflop
       .Imm_J(D_j),    // to extension then PC
       .Imm_AB(D_ab),   // to ALU or branch calculation
       .Data(D_im),     // input from IM
       .clk(clk));
reg [31:0] D_imm;  // signed extended 32 imm for ALU
always@(*)
begin
D_imm = {{16{D_ab[15]}}, D_ab};
end
wire [31:0] D_prev_pc;
flip_flop ir_phase (.d(D_pc),       // from PC
                    .clk(clk),
                    .reset(reset),
                    .q(D_prev_pc));      // to branch calculation
// branch adder
always@(*)
begin
D_b <= D_prev_pc + D_imm;
end

// RF
OPC_Decoder decoder (.D(opc_rf),              // decoded opcode, to flipflop
                     .Opcode(D_opc));
wire [31:0] D_reg_d1, D_reg_d2, ain3;
reg [31:0] data;
registerFile rf (.DOut1(D_reg_d1),
             .DOut2(D_reg_d2),
             .AIn1(D_rs1),   // rs1
             .AIn2(D_rs2),   // rs2
             .AIn3(ain3),   // rd 3 cycles later
             .DIn(data));   // data from WB stage
wire [31:0] D_alu_1, D_alu_2, D_alu_imm;
flip_flop #24 rf_phase_opc (.d(opc_rf),
                            .clk(clk),
                            .reset(reset),
                            .q(opc_alu));
flip_flop rf_phase_d1 (.d(D_reg_d1),   // from rf DOut1
                        .clk(clk),
                        .reset(reset),
                        .q(D_alu_1));      // to ALU
flip_flop rf_phase_d2 (.d(D_reg_d2),   // from rf DOut2
                       .clk(clk),
                       .reset(reset),
                       .q(D_alu_2));      // to ALU
flip_flop rf_phase_imm (.d(D_imm),       // from sext immediate value
                        .clk(clk),
                        .reset(reset),
                        .q(D_alu_imm));      // to ALU
wire [4:0] rd_rf_alu;
//                              load,       move,       not,        movei,      sli,            sri,        addi,       subi
flip_flop #5 rf_phase_rd (.d((opc_rf[3] | opc_rf[4] | opc_rf[14] | opc_rf[15] | opc_rf[16] | opc_rf[17] | opc_rf[18] | opc_rf[19]) ? D_rs2 : D_rd),
                          .clk(clk),
                          .reset(reset),
                          .q(rd_rf_alu));
// comparer for sel_b
always@(*)
begin
if (D_reg_d1 === {{27{D_rs2[4]}}, D_rs2} && opc_rf[21])
    sel_b <= 1;
else
    sel_b <= 0;
end

// ALU
wire [31:0] D_alu_val, D_mem_addr, D_dm_imm, D_alu_final, D_alu_fmult, D_alu_fadd;
wire [23:0] opc_dm;
ALU alu (.DOut(D_alu_val),
         .Drs1(D_alu_1),    // need a mux to choose data input
         .Drs2(D_alu_2),
         .Dimm(D_alu_imm),
         .Opc(opc_alu));
wire [31:0] D_mem_in;
mux3to1 floatimplement (.Data(D_alu_final), .D0(D_alu_val), .D1(D_alu_fadd), .D2(D_alu_fmult), .sel(opc_alu[23:22]));
FloatAdder fadd (.num1(D_alu_1), .num2(D_alu_2), .sum(D_alu_fadd));
floatingmultiplier fmult (.num1(D_alu_1), .num2(D_alu_2), .product(D_alu_fmult));
flip_flop #24 alu_phase_opc (.d(opc_alu),
                             .clk(clk),
                             .reset(reset),
                             .q(opc_dm));
flip_flop alu_phase_rs1 (.d(D_alu_1),   // to mem for store
                         .clk(clk),
                         .reset(),
                         .q(D_mem_in));
flip_flop alu_phase_imm (.d(D_alu_imm),      // store imm for movei
                         .clk(clk),
                         .reset(reset),
                         .q(D_dm_imm));
flip_flop alu_phase_alu (.d(D_alu_final),
                         .clk(clk),
                         .reset(reset),
                         .q(D_mem_addr));     // to data mem
wire [31:0] rd_alu_dm;
flip_flop alu_phase_rd (.d(rd_rf_alu),
                        .clk(clk),
                        .reset(reset),
                        .q(rd_alu_dm));
                        
// DM
wire [31:0] D_mem_out, D_move, D_movei, D_mem, D_alu;
dataMemory mem (.DOut(D_mem_out),
              .AIn(D_mem_addr),
              .DIn(D_mem_in),
              .WE(opc_dm[2]));
wire [23:0] opc_wb;
flip_flop #24 dm_phase_opc (.d(opc_dm),
                            .clk(clk),
                            .reset(reset),
                            .q(opc_wb));
flip_flop dm_phase_rs1 (.d(D_mem_in),
                        .clk(clk),
                        .reset(reset),
                        .q(D_move));    // to mux for WB
flip_flop dm_phase_imm (.d(D_dm_imm),
                        .clk(clk),
                        .reset(reset),
                        .q(D_movei));   // to mux for WB
flip_flop dm_phase_mem (.d(D_mem_out),
                        .clk(clk),
                        .reset(reset),
                        .q(D_mem));     // to mux for WB
flip_flop dm_phase_alu (.d(D_mem_addr),
                        .clk(clk),
                        .reset(reset),
                        .q(D_alu));     // to mux for WB
flip_flop dm_phase_rd (.d(rd_alu_dm),
                       .clk(clk),
                       .reset(reset),
                       .q(ain3));
always@(*)
case(opc_wb)
24'b000000000000000000010000: data <= D_move;   // select move to write back
24'b000000001000000000000000: data <= D_movei;  // select movei to write back
24'b000000000000000000001000: data <= D_mem;    // select data mem to write back
// floating point selection adds here
default:                      data <= D_alu;    // select alu value to write back
endcase
endmodule
