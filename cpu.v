`timescale 1ns/1ns
`define WORD_SIZE 16    // data and address word size

module cpu(clk, reset_n, readM, writeM, address, data, num_inst, output_port, is_halted);
	input clk;
	input reset_n;
	
	output readM;
	output writeM;
	output [`WORD_SIZE-1:0] address;

	inout [`WORD_SIZE-1:0] data;

	output [`WORD_SIZE-1:0] num_inst;		// number of instruction during execution (for debuging & testing purpose)
	output [`WORD_SIZE-1:0] output_port;	// this will be used for a "WWD" instruction
	output is_halted;

	wire [`WORD_SIZE - 1:0] address;
	reg [`WORD_SIZE - 1:0] num_inst;
	reg [`WORD_SIZE - 1:0] output_port;
	wire is_halted;

	reg [`WORD_SIZE - 1:0] pc;

	// instruction sub parts
	reg [3:0] opcode;
	reg [1:0] rs;
	reg [1:0] rt;
	reg [1:0] rd;
	reg [5:0] func;
	reg [7:0] imm;
	reg [11:0] target_address;

	// control unit
	wire PCWriteCond;
	wire PCWrite;
	wire IorD;
	wire MemRead;
	wire MemWrite;
    wire MemtoReg;
    wire IRWrite;
    wire PCSource;
    wire [3:0] ALUOp;
    wire [1:0] ALUSrcB;
    wire ALUSrcA;
    wire RegWrite;

	// for choosing destination register index
	wire [1:0] RegDst;
	wire InstFlag;

	controller control_unit(clk, opcode, func, PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite);


	// registers
	wire [1:0] rs_input, rt_input, rd_input;
	wire [`WORD_SIZE - 1:0] write_data;
	wire [`WORD_SIZE - 1:0] data_1, data_2;

	assign rs_input = rs;
	assign rt_input = rt;

	reg_manager Registers(rs_input, rt_input, rd_input, write_data, RegWrite, data_1, data_2); // 따로 새로운 wire을 만들 이유가?


	// immediate generator
	wire [`WORD_SIZE - 1:0] zero_extended_8_imm, sign_extended_8_imm, sign_extended_target;

	imm_generator immGen(imm, target_address, zero_extended_8_imm, sign_extended_8_imm, sign_extended_target);


	// multiplexer instuction or data memory
	wire [`WORD_SIZE - 1:0] memory_address;
	assign address = memory_address;

	2_1mux IorD_MUX(ALU_result, pc, IorD, memory_address);

	// multiplexer register write data
	//2_1mux MemtoReg_MUX(ALU_result, MemtoReg, write_data);

	// multiplexer ALU source A
	//2_1mux ALUSrcA_MUX(data_1, pc, ALUSrcA, ALU_input_1);

	// multiplexer ALU source B
	//4_1mux ALUSrcB_MUX(ALUSrcB, ALU_input_2);

	// multiplexer used immediate value
	wire [`WORD_SIZE - 1:0] used_imm;
	//4_1mux ImmGenSig_MUX(zero_extended_8_imm, sign_extended_8_imm, sign_extended_target, ImmGenSig, used_imm);

	// multiplexer Write data register index
	4_1mux MUX4(rs, rt, rd, 16'h0002, RegDst, rd_input);


	// ALU
	wire [`WORD_SIZE - 1:0] ALU_input_1, ALU_input_2;
	wire [`WORD_SIZE - 1:0] ALU_result;
	wire bcond;

	alu ALU(ALUOp, ALU_input_1, ALU_input_2, ALU_result, bcond);

	//assign data = 

	initial begin
		pc = 16'h0000;
		num_inst = 0;
	end

	always @(posedge InstFlag)
		begin
			num_inst = num_inst + 1;
		end

	
	always @(posedge IRWrite)
		begin
			opcode = data[15:12];
			rs = data[11:10];
			rt = data[9:8];
			rd = data[7:6];
			func = data[5:0];
			imm = data[7:0];
			target_address = data[11:0];
		end

endmodule
