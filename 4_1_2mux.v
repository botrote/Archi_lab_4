`include "opcodes.v"

module MUX4_1_2 (i1, i2, i3, i4, s, result);

    input [1 : 0] i1;
    input [1 : 0] i2;
    input [1 : 0] i3;
    input [1 : 0] i4;
    input [1 : 0] s;

    output [1 : 0] result;

    wire [1:0] result;

    assign result = s[1] ? (s[0] ? i4 : i3) : (s[0] ? i2 : i1); 

endmodule