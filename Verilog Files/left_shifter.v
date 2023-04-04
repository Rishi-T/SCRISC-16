`timescale 1ns / 1ps

module left_shifter(
    output [15:0] out,
    input [15:0] in,
    input [4:0] sh
    );
    
    wire [15:0] st1,st2,st3,st4;
    
    mux_2x1_16b u1(st1,in,16'h0000,sh[4]);
    mux_2x1_16b u2(st2,st1,{st1[7:0],8'h00},sh[3]);
    mux_2x1_16b u3(st3,st2,{st2[11:0],4'h0},sh[2]);
    mux_2x1_16b u4(st4,st3,{st3[13:0],2'b00},sh[1]);
    mux_2x1_16b u5(out,st4,{st4[14:0],1'b0},sh[0]);
    
endmodule
