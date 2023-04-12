`timescale 1ns / 1ps

module bitwise_16b(
    output [15:0] out,
    input [15:0] a,
    input [15:0] b,
    input [1:0] funct
    );
    
    wire [15:0] d1,d2,d3,d4;
    wire [15:0] a1,a2,a3,a4,b1,b2,b3;
    wire [15:0] o1,o2,o3,o4;
    wire [15:0] m1,m2;
    
    demux_1x2_16b da1(d1,d2,a,funct[1]);
    demux_1x2_16b da2(a1,a2,d1,funct[0]);
    demux_1x2_16b da3(a3,a4,d2,funct[0]);
    
    demux_1x2_16b db1(d3,d4,b,funct[1]);
    demux_1x2_16b db2(b1,b2,d3,funct[0]);
    demux_1x2_16b db3(b3,,d4,funct[0]);
    
    btwand_16b btwand(o1,a1,b1);
    btwor_16b btwor(o2,a2,b2);
    btwxor_16b btwxor(o3,a3,b3);
    btwnot_16b btwnot(o4,a4);
    
    mux_2x1_16b mx1(m1,o1,o2,funct[0]);
    mux_2x1_16b mx2(m2,o3,o4,funct[0]);
    mux_2x1_16b mx3(out,m1,m2,funct[1]);
    
endmodule
