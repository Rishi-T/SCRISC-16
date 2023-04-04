`timescale 1ns / 1ps

module ALUControl(
    output [3:0] ALUC,
    input [1:0] ALUOp,
    input [4:0] funct5
    );
    
    wire [3:0] ALUC0, ALUC1;
    
    assign ALUC0[0] = ~ALUOp[0];
    assign ALUC0[1] = 0;
    assign ALUC0[2] = ALUOp[1] | ALUOp[0];
    assign ALUC0[3] = ALUC0[2];
    
    penc_2b encoder(ALUC1[3:2],funct5[4:2]);
    assign ALUC1[1] = funct5[1];
    assign ALUC1[0] = funct5[0] | (~&(ALUC1[3:2]) & funct5[1]);
    
    mux_2x1_4b mux(ALUC,ALUC0,ALUC1,&ALUOp);
     
endmodule

module mux_2x1_4b#(parameter N=4)(
    output [N-1 : 0] out,
    input [N-1 : 0] in0,
    input [N-1 : 0] in1,
    input sel
    );
    
    assign out  = sel ? in1 : in0;
endmodule