`include "opcodes.v"

module ImmGen(data, imm8zero, imm8sign, imm12sign);
    input [`WORD_SIZE - 1 : 0] data;
    output [`WORD_SIZE - 1 : 0] imm8zero;
    output [`WORD_SIZE - 1 : 0] imm8sign;
    output [`WORD_SIZE - 1 : 0] imm12sign;

    assign imm8zero = ((data << 8) >> 8);
    assign imm8sign = (($signed(data << 8)) >>> 8);
    assign imm12sign = (($signed(data << 4)) >>> 4);

endmodule