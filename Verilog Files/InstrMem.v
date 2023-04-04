`timescale 1ns / 1ps

module InstrMem(
    output [15:0] Instr_Code,
    input [15:0] PC,
    input reset
    );
    
    reg [7:0] mem [63:0]; //byte addressable memory with 48 locations
    
    assign Instr_Code = {mem[PC+1], mem[PC]}; //BigEndian
    
    always@(reset)
    begin
    if(reset)
        $readmemh("Instructions.mem",mem);
    end
endmodule