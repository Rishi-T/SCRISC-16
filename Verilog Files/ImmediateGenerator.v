`timescale 1ns / 1ps

module ImmediateGenerator(
    output [15:0] out,
    input [10:0] instr,
    input [2:0] ImmOp,
    input RegZero
    );
    
    wire [15:0] imm7,imm9;
    wire [15:0] in0,in1,in2,in3;
    wire [15:0] mx1,mx2,mx3;
    
    assign imm7 = {{9{instr[10]}},instr[10:6],instr[1:0]};
    assign imm9 = {{7{instr[10]}},instr[10:2]};
    
    mux_2x1_16b m1(mx1,imm7,imm9,ImmOp[0]);
    mux_2x1_16b m2(mx2,mx1,{mx1[14:0],1'b0},ImmOp[1]);
    mux_2x1_16b m3(mx3,mx2,{mx2[8:0],7'b0},ImmOp[2]);
    
    mux_2x1_16b m4(out,mx3,16'b0,RegZero);
    
endmodule
