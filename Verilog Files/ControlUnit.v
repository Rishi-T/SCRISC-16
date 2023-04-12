`timescale 1ns / 1ps

module ControlUnit(
    output [1:0] ALUOp,
    output [1:0] ALUB,
    output [3:0] ImmOp,
    output ALUSrc,
    output Branch,
    output Unsig,
    output Jump,
    output Direct,
    output RegZero,
    output MemRead,
    output BH,
    output MemtoReg,
    output RegWrite,
    output MemWrite,
    input [4:0] opcode
    );
    
    wire Rtype,addi,Itype,rstjal;
    
    assign addi = &(opcode[3:0]);
    assign Rtype = addi & opcode[4];
    assign Itype = ~opcode[4] & (opcode[3] | opcode[2]);
    assign rstjal = ~|(opcode[4:1]);
    
    assign ALUSrc = Itype | MemWrite;
    assign Branch = opcode[4] & ~opcode[3];
    assign Jump = (rstjal & ~opcode[0]) | ~opcode[4] & opcode[3] & ~opcode[2];
    assign Direct = ~|(opcode[4:2]);
    assign RegZero = rstjal & opcode[0];
    assign MemRead = ~opcode[4] & ~opcode[3] & opcode[2];
    assign BH = opcode[1];
    assign MemtoReg = MemRead;
    assign RegWrite = ~(opcode[4] & (~opcode[3] | opcode[3] & ~opcode[2]));
    assign MemWrite = opcode[4] & opcode[3] & ~opcode[2];
    
    assign ALUOp[0] = MemRead | MemWrite | Rtype | addi;
    assign ALUOp[1] = Branch | Rtype;
      
    assign ALUB = {opcode[2],opcode[1]}; // {btype,binv}
    assign Unsig = opcode[0];
    
    assign ImmOp = {Direct & opcode[0], Jump | Branch, Direct, Itype}; // {sll7,sll1,imm7/9,imm7type}
    
endmodule
