# SCRISC-16
SCRISC-16 is a 16-bit processor based on a fully custom instruction set architecture (ISA), inspired by RISC-V.
- All instructions are 2 Bytes wide
- The processor has 4 general-purpose registers - r0 (00), r1 (01), r2 (10) & r3 (11)
- *opcode* field specifies the operation to be performed. It also implicitly specifies the instruction format
- rs1 specifies the first source register and rs2 specifies the second
- rd specifies the destination register
- imm[x:y] specifies the immediate operand along with the mapping of its bits

![Formats](https://user-images.githubusercontent.com/36669914/229862761-888dc9af-edd7-4705-9e9b-48f80cf26c40.png)

|Instruction|opcode|funct5| Format|Function|
|:---|:---|:---|:---|:---|
|jal|00000|NA|J-Type|rd ← pc + 2 ; pc ← pc + imm9 << 1|
|rst|00001|NA|U-Type|rd ← 0|
|li|00010|NA|U-Type|rd ← imm9|
|lui|00011|NA|U-Type|rd ← imm9 << 7|
|lb|00100|NA|I-Type|rd ← mem[rs1 + imm7] (sign-extend)|
|lbu|00101|NA|I-Type|rd ← mem[rs1 + imm7]|
|lh|00110|NA|I-Type|rd ← mem[rs1 + imm7]|
|jalr|01000|NA|I-Type|rd ← pc + 2 ; pc ← rs1 + imm7 << 1|
|addi|01111|NA|I-Type|rd ← rs1 + imm7|
|beq|10000|NA|B-Type|if rs1 == rs2, pc ← pc + imm7 << 1|
|bne|10010|NA|B-Type|if rs1 != rs2, pc ← pc + imm7 << 1|
|blt|10100|NA|B-Type|if rs1 < rs2 (signed), pc ← pc + imm7 << 1|
|bltu|10101|NA|B-Type|if rs1 < rs2, pc ← pc + imm7 << 1|
|bge|10110|NA|B-Type|if rs1 >= rs2 (signed), pc ← pc + imm7 << 1|
|bgeu|10111|NA|B-Type|if rs1 >= rs2, pc ← pc + imm7 << 1|
|sb|11000|NA|S-Type|rs2(7:0) → mem[rs1 + imm7]|
|sh|11010|NA|S-Type|rs2(15:0) → mem[rs1 + imm7]|
|sll|11111|00000|R-Type|rd ← rs1 << rs2|
|srl|11111|00001|R-Type|rd ← rs1 >> rs2|
|sra|11111|00011|R-Type|rd ← rs1 >> rs2 (sign-extend)|
|and|11111|00100|R-Type|rd ← rs1 & rs2|
|or|11111|00101|R-Type|rd ← rs1 | rs2|
|xor|11111|00110|R-Type|rd ← rs1 ^ rs2|
|not|11111|00111|R-Type|rd ← ~(rs1)|
|add|11111|01000|R-Type|rd ← rs1 + rs2|
|sub|11111|01001|R-Type|rd ← rs1 - rs2|
