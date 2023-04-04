`timescale 1ns / 1ps

module Datapath(
    input clk,
    input reset
    );
    reg [15:0] PC;
    wire [15:0] Instr,RsDat1,RsDat2,RdDat,Imm,ALUOut,ReadData,WriteData,PCIncr,PCNext,BranchAddr;
    wire [15:0] wr1,wr2,ldbyte,lddat;
    wire [3:0] ALUC;
    wire [2:0] ImmOp;
    wire [1:0] ALUB,ALUOp;
    wire ALUSrc,Branch,Unsig,Jump,Direct,RegZero,MemRead,BH,MemtoReg,RegWrite,MemWrite,PCSrc,Check;
    
    always@(posedge clk or posedge reset)
    begin
    if (reset)
        PC <= 0;
    else
        PC <= PCNext;
    end
    
    InstrMem mem1(Instr,PC,reset);
    ControlUnit cont(ALUOp,ALUB,ImmOp,ALUSrc,Branch,Unsig,Jump,Direct,RegZero,MemRead,BH,MemtoReg,RegWrite,MemWrite,Instr[4:0]);
    RegisterFile u4(RsDat1,RsDat2,RdDat,Instr[8:7],Instr[10:9],Instr[6:5],RegWrite,clk,reset);
    ImmediateGenerator immgen(Imm,Instr[15:5],ImmOp,RegZero);
    ALUControl alucont(ALUC,ALUOp,Instr[15:11]);
    ALU_16b alu(ALUOut,Check,RsDat1,ALUSrc?Imm:RsDat2,ALUC,ALUB,Unsig);
    DataMem mem2(ReadData,ALUOut,WriteData,MemRead,MemWrite,BH,clk,reset);
    
    assign PCIncr = PC + 2;
    assign BranchAddr = PC + Imm;
    assign PCSrc = Jump | (Branch & Check);
    assign PCNext = PCSrc ? BranchAddr : PCIncr;
    
    assign WriteData = BH ? RsDat2 : {8'b0,RsDat2[7:0]};
    
    assign ldbyte = {{4{~Unsig & ReadData[15]}},ReadData[7:0]};
    assign lddat = BH ? ReadData : ldbyte;
    assign wr1 = MemtoReg ? lddat : ALUOut;
    assign wr2 = Jump ? PCIncr : wr1;
    assign RdDat = (~Jump & Direct) ? Imm : wr2;
    
endmodule
