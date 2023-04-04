`timescale 1ns / 1ps

module ControlUnit(
    output [1:0] ALUOp,
    output [2:0] ALUB,
    output [2:0] ImmOp,
    output ALUSrc,
    output Branch,
    output Jump,
    output MemRead,
    output MemtoReg,
    output RegWrite,
    output MemWrite,
    input [4:0] opcode
    );
    
    wire Rtype, direct;
    
    assign Rtype = &(opcode);
    assign direct = ~|(opcode[4:2]);
    
    assign ALUSrc = ~Rtype;
    assign Branch = opcode[4] & ~opcode[3];
    assign Jump = ~|(opcode) | ~opcode[4] & opcode[3] & ~opcode[2];
    assign MemRead = ~opcode[4] & ~opcode[3] & opcode[2];
    assign MemtoReg = MemRead;
    assign RegWrite = ~(opcode[4] & (~opcode[3] | opcode[3] & ~opcode[2]));
    assign MemWrite = opcode[4] & opcode[3] & ~opcode[2];
    
    assign ALUOp[0] = MemRead | Rtype;
    assign ALUOp[1] = Branch | Rtype;
      
    assign ALUB = {opcode[3],opcode[1],opcode[0]}; // {btype,binv,bunsig}
    
    assign ImmOp = {direct & opcode[0], Jump | Branch, direct}; // {sll7,sll1,imm7/9}
    
endmodule
