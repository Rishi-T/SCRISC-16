`timescale 1ns / 1ps

module ImmediateGenerator(
    output [15:0] out,
    input [10:0] instr,
    input [3:0] ImmOp,
    input RegZero
    );
    
    wire [15:0] imm7,imm9;
    wire [15:0] mx1,mx2,mx3;
    
    assign imm7 = ImmOp[0] ? {{9{instr[10]}},instr[10:4]} : {{9{instr[10]}},instr[10:6],instr[1:0]};
    assign imm9 = {{7{instr[10]}},instr[10:2]};
    
    assign mx1 = ImmOp[1] ? imm9 : imm7;
    assign mx2 = ImmOp[2] ? {mx1[14:0],1'b0} : mx1;
    assign mx3 = ImmOp[3] ? {mx2[8:0],7'b0} : mx2;
    
    assign out = RegZero ? 16'b0 : mx3;
    
endmodule
