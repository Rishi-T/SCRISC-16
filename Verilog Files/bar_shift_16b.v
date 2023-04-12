`timescale 1ns / 1ps

module bar_shift_16b(
    output [15:0] out,
    input [15:0] in,
    input [4:0] sh,
    input sign,
    input cont
    );
    
    wire [15:0] li,lo,ri,ro;
    wire [4:0] ls,rs;
    
    demux_1x2_16b d16(li,ri,in,cont);
    demux_1x2_5b d5(ls,rs,sh,cont);
    
    left_shifter lsh(lo,li,ls);
    right_shifter rsh(ro,ri,rs,sign);
    
    mux_2x1_16b m16(out,lo,ro,cont);
endmodule
