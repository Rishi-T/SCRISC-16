`timescale 1ns / 1ps

module Datapath(
    input clk,
    input reset
    );
    reg [15:0] PC;
    wire [15:0] Instr,RsDat1,RsDat2,WrDat,Imm,ALUOut,ReadData,PCIncr,PCNext,BranchAddr;
    wire [15:0] wr1,wr2;
    wire [3:0] ALUC;
    wire [2:0] ALUB,ImmOp;
    wire [1:0] ALUOp;
    wire ALUSrc,Branch,Jump,Direct,RegZero,MemRead,MemtoReg,RegWrite,MemWrite,PCSrc,Check;
    
    always@(posedge clk or posedge reset)
    begin
    if (reset)
        PC <= 0;
    else
        PC <= PCNext;
    end
    
    InstrMem mem1(Instr,PC,reset);
    ControlUnit cont(ALUOp,ALUB,ImmOp,ALUSrc,Branch,Jump,Direct,RegZero,MemRead,MemtoReg,RegWrite,MemWrite,Instr[4:0]);
    RegisterFile u4(RsDat1,RsDat2,WrDat,Instr[8:7],Instr[10:9],Instr[6:5],RegWrite,clk,reset);
    ImmediateGenerator immgen(Imm,Instr[15:5],ImmOp,RegZero);
    ALUControl alucont(ALUC,ALUOp,Instr[15:11]);
    ALU_16b alu(ALUOut,Check,RsDat1,ALUSrc?Imm:RsDat2,ALUC,ALUB);
    DataMem mem2(ReadData,ALUOut,RsDat2,MemRead,MemWrite,clk,reset);
    
    assign PCIncr = PC + 2;
    assign BranchAddr = PC + Imm;
    assign PCSrc = Jump | (Branch & Check);
    assign PCNext = PCSrc ? BranchAddr : PCIncr;
    
    assign wr1 = MemtoReg ? ReadData : ALUOut;
    assign wr2 = Jump ? PCIncr : wr1;
    assign WrDat = (~Jump & Direct) ? Imm : wr2;
    
endmodule
