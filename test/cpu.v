`include "opcodes.v"

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
	wire [`WORD_SIZE - 1: 0] address;
	reg [`WORD_SIZE - 1: 0] num_inst;
	reg [`WORD_SIZE - 1: 0] output_port;
	reg [`WORD_SIZE - 1: 0] copydata;
	wire is_halted;

	wire [1:0]rs_num;
	wire [1:0]rt_num;
	wire [1:0]rd_num;
	wire [1:0]writenum;
	wire [`WORD_SIZE - 1:0]writedata;
	wire regwrite;
	wire [`WORD_SIZE - 1:0]rs_data;
	wire [`WORD_SIZE - 1:0]rt_data;

	wire [`WORD_SIZE - 1: 0] muxaddress;

	wire [`WORD_SIZE - 1: 0]aluin1;
	wire [`WORD_SIZE - 1: 0]aluin2;
	wire [4:0]alufunc;
	wire [`WORD_SIZE -1:0]aluout;
	wire bcond;
	wire [`WORD_SIZE -1:0]pcwritewire;

	reg [3:0]opcode;
	reg [1:0]rs;
	reg [1:0]rt;
	reg [1:0]rd;
	reg [5:0]func;
	reg [`WORD_SIZE - 1: 0]pc;
	reg [`WORD_SIZE - 1: 0]MDR;
	reg [`WORD_SIZE - 1 : 0]aluout_reg;

	wire iswrite;

	wire [`WORD_SIZE - 1 : 0]z8imm;
	wire [`WORD_SIZE - 1 : 0]s8imm;
	wire [`WORD_SIZE - 1 : 0]s12imm;
	wire [`WORD_SIZE - 1 : 0]immout;

	wire instsig;
	wire pcupdate;
	wire PCWriteCond;
	wire PCWrite;
	wire IorD;
	wire MEMRead;
	wire MEMWrite;
	wire MeMtoReg;
	wire IRWrite;
	wire RegWrite;
	wire aluoutWrite;
	wire MDRWrite;
	wire ALUSrcA;
	wire output_sig;
	wire [1:0]ALUSrcB;
	wire ALUOp;
	wire PCSource;
	wire [1:0]extendsignal;
	wire [1:0]WriteMux;
	wire haltsig;
	
	assign data = iswrite ? rt_data : `WORD_SIZE'bz;
	assign pcupdate = (PCWrite || (PCWriteCond && bcond));
	assign address = muxaddress;
	assign rs_num = rs;
	assign rt_num = rt;
	assign rd_num = rd;
	assign readM = MEMRead;
	assign writeM = MEMWrite;
	assign regwrite = RegWrite;
	assign is_halted = haltsig;

	ALU aluu_ut(aluin1, aluin2, alufunc, aluout, bcond);
	register reg_uut(rs_num, rt_num, writenum, writedata, regwrite, rs_data, rt_data);
	Control ucontroller(clk, opcode, func, PCWriteCond, PCWrite, IorD, MEMRead, MEMWrite, MeMtoReg, IRWrite, PCSource, alufunc, ALUSrcB, ALUSrcA, RegWrite, iswrite, extendsignal, aluoutWrite, output_sig, WriteMux, instsig, MDRWrite, haltsig);
	ImmGen imm_uut(copydata, z8imm, s8imm, s12imm);
	MUX2 iordMux(pc, aluout_reg, IorD, muxaddress);
	MUX2 aluaMux(pc, rs_data, ALUSrcA, aluin1);
	MUX4 alubMux(rt_data, 16'h0001, immout, 16'h0000, ALUSrcB, aluin2);
	MUX2 pcsourceMux(aluout, aluout_reg, PCSource, pcwritewire);
	MUX2 MemtoRegMux(aluout_reg, MDR, MeMtoReg, writedata);
	MUX4 immMux(z8imm, s8imm, s12imm, 16'h0000, extendsignal, immout);
	MUX4 writeMux(rs, rt, rd, 16'h0002, WriteMux, writenum);

	initial begin
			pc = 16'h000;
			num_inst = -1;
		end

	always @(posedge instsig) begin
		num_inst = num_inst + 1;
	end

	always @(posedge output_sig) begin
		output_port = rs_data;
	end

	always @(posedge IRWrite) begin
			opcode = data[15:12];
			rs = data[11:10];
			rt = data[9:8];
			rd = data[7:6];
			func = data[5:0];
			copydata = data;
	end

	always @(posedge aluoutWrite) begin
		aluout_reg = aluout;
	end

	always @(posedge pcupdate) begin
		pc = pcwritewire;
	end

	always @(posedge MDRWrite) begin
		MDR = data;
	end
endmodule
