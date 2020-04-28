`include "opcodes.v"

module MUX2_1 (i1, i2, s, result);

    input [`WORD_SIZE - 1 : 0] i1;
    input [`WORD_SIZE - 1 : 0] i2;
    input s;

    output [`WORD_SIZE - 1 : 0] result;

    assign result = s ? i2 : i1; 

endmodule