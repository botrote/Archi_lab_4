`include "opcodes.v"

module MUX4 (A, B, C, D, sig, E);
input [`WORD_SIZE-1:0] A;
input [`WORD_SIZE-1:0] B;
input [`WORD_SIZE-1:0] C;
input [`WORD_SIZE-1:0] D;
input [1:0]sig;
output [`WORD_SIZE-1:0] E;
wire [`WORD_SIZE-1:0]E;

assign E = sig[1] ? (sig[0] ? D : C) : (sig[0] ? B : A);

endmodule
