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

	wire readM;
	wire writeM;
	wire [`WORD_SIZE - 1:0] address;
	reg [`WORD_SIZE - 1:0] num_inst;
	reg [`WORD_SIZE - 1:0] output_port;
	wire is_halted;

	//PC
	reg [`WORD_SIZE - 1:0] pc;
	wire [`WORD_SIZE - 1:0] newPC;

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
	// custom signals
	wire [1:0] RegDst;
	wire InstFlag;
	wire [1:0] ImmGenSig;
	wire HLTFlag;
	wire WWDFlag;
	wire ALURegWrite;
	wire MDRWrite;
	wire write_data;

	// decode signals
	//wire decode_signal_reg;
	//wire decode_signal_inst;

	// registers
	reg [`WORD_SIZE - 1:0] ALUReg;
	reg [`WORD_SIZE - 1:0] MDR;

	wire [1:0] rs_input, rt_input, rd_index;
	wire [`WORD_SIZE - 1:0] reg_write_data;
	wire [`WORD_SIZE - 1:0] data_1, data_2;
	assign rs_input = rs;
	assign rt_input = rt;

	// immediate generator
	//reg [`WORD_SIZE - 1:0] immgen_input;
	wire [`WORD_SIZE - 1:0] zero_extended_8_imm, sign_extended_8_imm, sign_extended_target;

	// ALU
	wire [`WORD_SIZE - 1:0] ALU_input_1, ALU_input_2;
	wire [`WORD_SIZE - 1:0] ALU_result;
	wire bcond;

	// multiplexer instuction or data memory
	wire [`WORD_SIZE - 1:0] memory_address;

	// multiplexer ALU source B
	wire [`WORD_SIZE - 1:0] used_imm;

	control_unit control_unit1(clk, opcode, func, PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, RegDst, InstFlag, ImmGenSig, HLTFlag, WWDFlag, ALURegWrite, MDRWrite, write_data);
	Reg_Manager Registers(rs_input, rt_input, RegWrite, rd_index, reg_write_data, data_1, data_2);
	immediate_generator immGen(imm, target_address, zero_extended_8_imm, sign_extended_8_imm, sign_extended_target);
	alu ALU(ALUOp, ALU_input_1, ALU_input_2, ALU_result, bcond);

	MUX2_1 PCSource_MUX(ALU_result, ALUReg, PCSource, newPC); // fin
	MUX2_1 IorD_MUX(pc, ALUReg, IorD, memory_address); // fin
	MUX2_1 MemtoReg_MUX(ALUReg, MDR, MemtoReg, reg_write_data); //fin
	MUX2_1 ALUSrcA_MUX(data_1, pc, ALUSrcA, ALU_input_1); // fin
	MUX4_1_16 ALUSrcB_MUX(data_2, 16'h0001, used_imm, 16'h0000, ALUSrcB, ALU_input_2); // fin
	MUX4_1_16 ImmGenSig_MUX(zero_extended_8_imm, sign_extended_8_imm, sign_extended_target, 16'h0000, ImmGenSig, used_imm); // fin
	MUX4_1_2 RegDst_MUX4(rs, rt, rd, 2'b10, RegDst, rd_index); // fin


	assign readM = MemRead;
	assign writeM = MemWrite;
	assign address = memory_address;
	assign data = write_data ? data_2 : `WORD_SIZE'bz;

	initial begin
		pc = 16'h0000;
		num_inst = -1;
	end

	always @(posedge InstFlag)
		begin
			num_inst = num_inst + 1;
		end

	wire pcChangeCond;
	assign pcChangeCond = PCWrite || (PCWriteCond && bcond);
	always @(posedge pcChangeCond)
		begin
			//$display("original PC: %d, new PC: %d", pc, newPC);

			pc = newPC;
		end

	/*
	always @(posedge decode_signal_inst)
		begin
			$display("opcode: %d rs: %d rt: %d rd: %d func: %d imm: %d target: %d", opcode, rs, rt, rd, func, imm, target_address);
		end

	always @(posedge decode_signal_reg)
		begin
			$display("data @ rs1: %d, data @ rs2: %d", data_1, data_2);
		end
	*/

	always @(posedge WWDFlag)
		begin
			output_port = data_1;
			//$display("output_port %d", output_port);
		end

	assign is_halted = HLTFlag;
	
	always @(posedge IRWrite)
		begin
			opcode = data[15:12];
			rs = data[11:10];
			rt = data[9:8];
			rd = data[7:6];
			func = data[5:0];
			imm = data[7:0];
			target_address = data[11:0];
			//immgen_input = data;

			//$display("New instruction start");
			//$display("opcode: %d, rs: %d rt: %d, rd: %d, func: %d", opcode, rs, rt, rd, func);
			//$display("imm: %d, target: %d", data[7:0], data[11:0]);
		end

	always @(posedge ALURegWrite)
		begin
			ALUReg = ALU_result;

		end

	always @(posedge MDRWrite)
		begin
			MDR = data;
		end

endmodule
