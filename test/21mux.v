`include "opcodes.v"

module MUX2 (A, B, sig, C);
input [`WORD_SIZE-1:0] A;
input [`WORD_SIZE-1:0] B;
input sig;

output [`WORD_SIZE-1:0] C;
wire [`WORD_SIZE-1:0]C;

assign C = sig ? B : A;

endmodule
