`timescale 1ns / 1ps

module right_shifter(
    output [15:0] out,
    input [15:0] in,
    input [4:0] sh,
    input sign
    );
    
    wire [15:0] st1,st2,st3,st4;
    wire ext;
    
    and sgn(ext,sign,in[15]);
    
    mux_2x1_16b u1(st1,in,{16{ext}},sh[4]);
    mux_2x1_16b u2(st2,st1,{{8{ext}},st1[15:8]},sh[3]);
    mux_2x1_16b u3(st3,st2,{{4{ext}},st2[15:4]},sh[2]);
    mux_2x1_16b u4(st4,st3,{{2{ext}},st3[15:2]},sh[1]);
    mux_2x1_16b u5(out,st4,{ext,st4[15:1]},sh[0]);
    
endmodule