`include "opcodes.v"

module MUX4_1_16 (i1, i2, i3, i4, s, result);

    input [`WORD_SIZE - 1 : 0] i1;
    input [`WORD_SIZE - 1 : 0] i2;
    input [`WORD_SIZE - 1 : 0] i3;
    input [`WORD_SIZE - 1 : 0] i4;
    input [1 : 0] s;

    output [`WORD_SIZE - 1 : 0] result;

    wire [`WORD_SIZE - 1:0] result;

    assign result = s[1] ? (s[0] ? i4 : i3) : (s[0] ? i2 : i1); 

endmodule