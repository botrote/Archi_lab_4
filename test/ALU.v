`include "opcodes.v"
`define	NumBits	16

module ALU (A, B, FuncCode, C, bcond);
	input [`NumBits-1:0] A;
	input [`NumBits-1:0] B;
	input [4:0] FuncCode;
	output [`NumBits-1:0] C;
	output bcond;

	reg [`NumBits-1:0] C;
	reg bcond;

	integer i;

	initial begin
		C = 0;
	end

	function [`NumBits-1:0]ADD;
		input [`NumBits-1:0]A;
		input [`NumBits-1:0]B;
		begin
			ADD = (A + B);
		end
	endfunction

	function [`NumBits-1:0]SUB;
		input [`NumBits-1:0]A;
		input [`NumBits-1:0]B;
		begin
			SUB = (A - B);
		end
	endfunction

	function [`NumBits-1:0]BEQ;
		input [`NumBits-1:0]A;
		input [`NumBits-1:0]B;
		begin
			BEQ = (A - B);
			if (BEQ == 0) begin
				bcond = 1;
			end
			else begin
				bcond = 0;
			end
		end
	endfunction

	function [`NumBits-1:0]BNE;
		input [`NumBits-1:0]A;
		input [`NumBits-1:0]B;
		begin
			BNE = (A - B);
			if (BNE == 0) begin
				bcond = 0;
			end
			else begin
				bcond = 1;
			end
		end
	endfunction

	function [`NumBits-1:0]BLZ;
		input [`NumBits-1:0]A;
		input [`NumBits-1:0]B;
		begin
			BLZ = (A - B);
			if (BLZ == 0) begin
				bcond = 0;
			end
			else begin
				if(BLZ[`NumBits - 1] == 0) begin
					bcond = 0;
				end
				else begin
					bcond = 1;
				end
			end
		end
	endfunction

	function [`NumBits-1:0]BGZ;
		input [`NumBits-1:0]A;
		input [`NumBits-1:0]B;
		begin
			BGZ = (A - B);
			if (BGZ == 0) begin
				bcond = 0;
			end
			else begin
				if(BGZ[`NumBits - 1] == 0) begin
					bcond = 1;
				end
				else begin
					bcond = 0;
				end
			end
		end
	endfunction

	function [`NumBits-1:0]JMP;
		input [`NumBits-1:0]A;
		input [`NumBits-1:0]B;
		begin
			JMP = ((A & 16'hf000)|B);
		end
	endfunction

	function [`NumBits-1:0]NOT;
		input [`NumBits-1:0]A;
		begin
			NOT = (~A);
		end
	endfunction


	function [`NumBits-1:0] OR;
		input [`NumBits-1:0] A;
		input [`NumBits-1:0] B;
		begin
			OR=(A|B);
		end
	endfunction

	function [`NumBits-1:0] AND;
		input [`NumBits-1:0] A;
		input [`NumBits-1:0] B;
		begin
			AND=(A&B);
		end
	endfunction

	function [`NumBits-1:0] TCP;
		input [`NumBits-1:0]A;
		begin
			TCP=(NOT(A)+1);
		end
	endfunction

	function [`NumBits-1:0]ARSN;
		input [`NumBits-1:0]A;
		input [`NumBits-1:0]B;
		begin
			for(i = 0; i < B; i = i + 1) begin
				if(A[`NumBits-1]==1)
					A = ((A>>1)+16'h8000);
				else
					A = (A>>1);
			end
			ARSN = A;
		end
	endfunction

	function [`NumBits-1:0]ARS;
		input [`NumBits-1:0]A;
		begin
			if(A[`NumBits-1]==1)
				A = ((A>>1)+16'h8000);
			else
				A = (A>>1);
			ARS = A;
		end
	endfunction

	function [`NumBits-1:0]EXT;
		input [7:0]A;
		begin
			EXT = (16'h0000 | A);
			EXT = ARSN(LLSN(EXT, 8), 8);
		end
	endfunction

	function [`NumBits-1:0]LRSN;
		input [`NumBits-1:0]A;
		input [`NumBits-1:0]B;
		begin
			A=(A>>B);
			LRSN = A;
		end
	endfunction

	function [`NumBits-1:0]LRS;
		input [`NumBits-1:0]A;
		begin
			A=(A>>1);
			LRS = A;
		end
	endfunction

	function [`NumBits-1:0]LLSN;
		input [`NumBits-1:0]A;
		input [`NumBits-1:0]B;
		begin
			A = (A<<B);
			LLSN = A;
		end
	endfunction

	function [`NumBits-1:0]LLS;
		input [`NumBits-1:0]A;
		begin
			A = (A<<1);
			LLS = A;
		end
	endfunction


	function [`NumBits-1:0]XNOR;
		input [`NumBits-1:0]A;
		input [`NumBits-1:0]B;
		begin
			XNOR=(A~^B);
		end
	endfunction

	function [`NumBits-1:0] XOR;
		input [`NumBits-1:0] A;
		input [`NumBits-1:0] B;
		begin
			XOR=(A^B);
		end
	endfunction

	function [`NumBits-1:0] NOR;
		input [`NumBits-1:0] A;
		input [`NumBits-1:0] B;
		begin
			NOR=NOT(OR(A,B));
		end
	endfunction

	function [`NumBits-1:0] NAND;
		input [`NumBits-1:0] A;
		input [`NumBits-1:0] B;
		begin
			NAND=NOT(AND(A,B));
		end
	endfunction

	function [`NumBits-1:0] LHI;
		input [`NumBits-1:0] B;
		begin
			LHI = (B<<8);
		end
	endfunction

	always @FuncCode begin
		case(FuncCode)
			`ALU_ADD: assign C = ADD(A, B);
			`ALU_SUB: assign C = SUB(A, B);
			`ALU_JMP: assign C = JMP(A, B);
			`ALU_NOT: assign C = NOT(A);
			`ALU_AND: assign C = AND(A, B);
			`ALU_OR: assign C = OR(A, B);
			`ALU_NAND: assign C = NAND(A, B);
			`ALU_NOR: assign C = NOR(A, B);
			`ALU_XOR: assign C = XOR(A, B);
			`ALU_XNOR: assign C = XNOR(A, B);
			`ALU_LLS: assign C =  LLS(A);
			`ALU_LRS: assign C =  LRS(A);
			`ALU_ARS: assign C =  ARS(A);
			`ALU_TCP: assign C =  TCP(A);
			`ALU_EXT: assign C =  EXT(A);
			`ALU_LLSN: assign C =  LLSN(A, B);
			`ALU_LRSN: assign C =  LRSN(A, B);
			`ALU_ARSN: assign C =  ARSN(A, B);
			`ALU_LHI: assign C =  LHI(B);
			`ALU_BEQ: assign C =  BEQ(A, B);
			`ALU_BNE: assign C =  BNE(A, B);
			`ALU_BGZ: assign C =  BGZ(A, B);
			`ALU_BLZ: assign C =  BLZ(A, B);
			`ALU_ZERO: assign C =  16'b0;
//			default: assign C = 16'b0;
		endcase
	end

	// TODOo: You should implement the functionality of ALU!
	// (HINT: Use 'always @(...) begin ... end')
	/*
		YOUR ALU FUNCTIONALITY IMPLEMENTATION...
	*/

endmodule
