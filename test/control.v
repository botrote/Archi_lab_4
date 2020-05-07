`timescale 1ns / 100ps
`include "opcodes.v"
`define	NumBits	16

module Control(clk, opcode, func, PCWriteCond, PCWrite, lorD, MemRead, MemWrite, MemtoReg, IRWrite, PCSource, ALUOp, ALUSrcB, ALUSrcA, RegWrite, isWrite, extendsignal, ALUoutWrite, output_sig, WriteMUX, instsig, MDRWrite, haltsig);
	inout clk;
	input [`WORD_SIZE - 1: 12]opcode;
	input [5:0]func;

	output PCWriteCond;
	output PCWrite;
	output lorD;
	output MemRead;
	output MemWrite;
	output MemtoReg;
	output IRWrite;
	output PCSource;
	output [4:0]ALUOp;
	output [1:0]ALUSrcB;
	output ALUSrcA;
	output RegWrite;


	output isWrite;
	output [1:0]extendsignal; // ImmGenSig
	output ALUoutWrite;
	output MDRWrite;
	output output_sig;
	output [1:0]WriteMUX; // RegDst
	output instsig; // InstFlag
	output haltsig; // HLTFlag

	reg PCWriteCond;
	reg PCWrite;
	reg lorD;
	reg MemRead;
	reg MemWrite;
	reg MemtoReg;
	reg IRWrite;
	reg PCSource;
	reg [4:0]ALUOp;
	reg [1:0]ALUSrcB;
	reg ALUSrcA;
	reg RegWrite;
	reg isWrite;
	reg [1:0]extendsignal;
	reg ALUoutWrite;
	reg output_sig;
	reg [1:0]WriteMUX;
	reg instsig;
	reg MDRWrite;
	reg haltsig;

	reg [`WORD_SIZE-1:0]State;


	function [`WORD_SIZE-1:0]NextState;
	   input [`WORD_SIZE-1:0]State;
	   input [3:0]Opcode;
	   begin
	   		if (State==`IF4 && Opcode==9)begin
	   			NextState=`EX1;
	   		end
			else if(State==`EX2 && (Opcode==15 || Opcode == 10 || Opcode == 9 || Opcode == 4 || Opcode == 5 || Opcode == 6)) begin
				NextState=`WB;
			end
			else if(State==`EX2 && (Opcode==0 || Opcode == 1 || Opcode == 2 || Opcode == 3)) begin
				NextState=`IF1;
			end
			else if(State==`MEM4 && Opcode==8) begin
				NextState=`IF1;
			end
	   		else begin
				if (State==`WB) begin
					NextState=`IF1;
				end
				else begin
					NextState=(State+1);
				end
			end
	   end
	endfunction


	initial begin
		State = -1;
		assign PCWriteCond=0;
		assign lorD=0;
		assign MemRead=0;
		assign MemWrite=0;
		assign MemtoReg=0;
		assign IRWrite=0;
		assign PCSource=0;
		assign ALUOp=0;
		assign ALUSrcB=2'b00;
		assign ALUSrcA=0;
		assign RegWrite=0;
		assign isWrite=0;
		assign extendsignal=0;
		assign ALUoutWrite=0;
		assign MDRWrite=0;
		assign WriteMUX=0;
		assign instsig=0;
		assign output_sig = 0;
		assign haltsig = 0;
	end

	always @(posedge clk) begin
		case(State)
			`IF1: begin
				assign instsig=1;
				assign PCWriteCond=0;
				assign lorD=0;
				assign MemRead=1;
				assign MemWrite=0;
				assign MemtoReg=0;
				assign IRWrite=0;
				assign PCSource=0;
				assign ALUOp=`ALU_ADD;
				assign ALUSrcB=2'b01;
				assign ALUSrcA=0;
				assign RegWrite=0;
				assign isWrite=0;
				assign extendsignal=0;
				assign ALUoutWrite=0;
				assign WriteMUX=0;
				assign PCWrite=0;
			end
			`IF2: begin
				assign instsig=0;
				assign PCWriteCond=0;
				assign lorD=0;
				assign MemRead=1;
				assign MemWrite=0;
				assign MemtoReg=0;
				assign IRWrite=0;
				assign PCSource=0;
				assign ALUOp=`ALU_ADD;
				assign ALUSrcB=2'b01;
				assign ALUSrcA=0;
				assign RegWrite=0;
				assign isWrite=0;
				assign extendsignal=0;
				assign ALUoutWrite=0;
				assign WriteMUX=0;
				assign PCWrite=0;
			end
			`IF3: begin
				assign PCWriteCond=0;
				assign lorD=0;
				assign MemRead=1;
				assign MemWrite=0;
				assign MemtoReg=0;
				assign IRWrite=1;
				assign PCSource=0;
				assign ALUOp=`ALU_ADD;
				assign ALUSrcB=2'b01;
				assign ALUSrcA=0;
				assign RegWrite=0;
				assign isWrite=0;
				assign extendsignal=0;
				assign ALUoutWrite=1;
				assign WriteMUX=0;
				assign PCWrite=0;
			end
			`IF4: begin
				assign PCWriteCond=0;
				assign lorD=0;
				assign MemRead=0;
				assign MemWrite=0;
				assign MemtoReg=0;
				assign IRWrite=0;
				assign PCSource=1;
				assign ALUOp=`ALU_ADD;
				assign ALUSrcB=2'b10;
				assign ALUSrcA=0;
				assign RegWrite=0;
				assign isWrite=0;
				assign extendsignal=2'b01;
				assign ALUoutWrite=0;
				assign WriteMUX=0;
				assign PCWrite=1;
			end
			`ID: begin
				assign PCWriteCond=0;
				assign lorD=0;
				assign MemRead=0;
				assign MemWrite=0;
				assign MemtoReg=0;
				assign IRWrite=0;
				assign PCSource=1;
				assign ALUSrcB=2'b10;
				assign ALUSrcA=0;
				assign RegWrite=0;
				assign isWrite=0;
				assign extendsignal=0;
				assign ALUoutWrite=0;
				assign WriteMUX=0;
				assign PCWrite=0;
				if(opcode >=0 && 3>= opcode) begin
					assign ALUoutWrite=1;
				end
			end
			`EX1: begin
				assign PCWriteCond=0;
				assign lorD=0;
				assign MemRead=0;
				assign MemWrite=0;
				assign MemtoReg=0;
				assign IRWrite=0;
				assign PCSource=1;
				assign RegWrite=0;
				assign isWrite=0;
				assign ALUoutWrite=0;
				assign WriteMUX=0;
				case(opcode)
				 `ADI_OP   :begin
				 		assign ALUSrcA=1;
						assign ALUSrcB=2'b10;
						assign extendsignal=2'b01;
						assign ALUOp=`ALU_ADD;
					end//4'd4
				 `ORI_OP   :begin
				 		assign ALUSrcA=1;
						assign ALUSrcB=2'b10;
						assign extendsignal=2'b01;
						assign ALUOp=`ALU_OR;
					end   //4'd5
				 `LHI_OP   :begin
				 		assign ALUSrcA=1;
						assign ALUSrcB=2'b10;
						assign extendsignal=2'b01;
						assign ALUOp=`ALU_LHI;//
					end   //4'd6
				 `LWD_OP   :begin
				 		assign ALUSrcA=1;
						assign ALUSrcB=2'b10;
						assign extendsignal=2'b01;
						assign ALUOp=`ALU_ADD;
					end   //4'd7
				 `SWD_OP   :begin
				 		assign ALUSrcA=1;
						assign ALUSrcB=2'b10;
						assign extendsignal=2'b01;
						assign ALUOp=`ALU_ADD;
					end   //4'd8
				 `BNE_OP   :begin
				 		assign ALUSrcA=1;
						assign ALUSrcB=2'b00;
						assign ALUOp=`ALU_BNE;
				 end   //4'd0
				 `BEQ_OP   :begin
				 		assign ALUSrcA=1;
						assign ALUSrcB=2'b00;
						assign ALUOp=`ALU_BEQ;
				 end   //4'd1
				 `BGZ_OP   :begin
				 		assign ALUSrcA=1;
						assign ALUSrcB=2'b11;
						assign ALUOp=`ALU_BGZ;
				 end   //4'd2
				 `BLZ_OP   :begin
				 		assign ALUSrcA=1;
						assign ALUSrcB=2'b11;
						assign ALUOp=`ALU_BLZ;
				 end   //4'd3
				 `JMP_OP   :begin
				 		assign ALUSrcA=0;
						assign ALUSrcB=2'b10;
						assign extendsignal=2'b10;
						assign ALUOp=`ALU_JMP;
						assign PCWrite=0;
				 end   //4'd9
				 `JAL_OP :begin
				 		assign ALUSrcA=0;
						assign ALUSrcB=2'b10;
						assign extendsignal=2'b10;
						assign ALUOp=`ALU_JMP;
						assign PCWrite=0;
				 end   //4'd10
				 default :begin
				 		assign ALUSrcA=1;
						assign ALUSrcB=2'b00;
						case(func)
						`FUNC_ADD : begin
							assign ALUOp=`ALU_ADD;
						end   //3'b000
						`FUNC_SUB : begin
							assign ALUOp=`ALU_SUB;
						end //3'b001
						`FUNC_AND : begin
							assign ALUOp=`ALU_AND;
						end   //3'b010
						`FUNC_ORR :   begin
							assign ALUOp=`ALU_OR;
						end//3'b011
						`FUNC_NOT :   begin
							assign ALUOp=`ALU_NOT;
						end   //3'b100
						`FUNC_TCP :   begin
							assign ALUOp=`ALU_TCP;
						end   //3'b101
						`FUNC_SHL : begin
							assign ALUSrcB=2'b01;
							assign ALUOp=`ALU_LLS;
						end      //3'b110
						`FUNC_SHR : begin
							assign ALUSrcB=2'b01;
							assign ALUOp=`ALU_ARS;
						end
						`INST_FUNC_JPR : begin
		   			 		assign ALUSrcA=1;
							assign ALUSrcB=2'b11;
							assign ALUOp=`ALU_ADD;
						end
						`INST_FUNC_JRL : begin
		   			 		assign ALUSrcA=1;
							assign ALUSrcB=2'b11;
							assign ALUOp=`ALU_ADD;
						end
						`INST_FUNC_WWD : begin
							assign output_sig=1;
						end
						`INST_FUNC_HLT : begin
							assign haltsig = 1;
						end
						endcase
					end
				endcase
			end
			`EX2:begin
					assign PCWrite=0;
					assign output_sig = 0;
					if(opcode==`ADI_OP || opcode==`LHI_OP || opcode == `ORI_OP || opcode == 15 || opcode == `LWD_OP || opcode == `SWD_OP) begin
						if(opcode == 15 && (func == `INST_FUNC_JPR || func == `INST_FUNC_JRL)) begin
							assign PCSource = 0;
							assign PCWrite = 1;
						end
						else begin
							assign ALUoutWrite = 1;
						end
					end

					else if(opcode==`BNE_OP || opcode==`BEQ_OP || opcode==`BGZ_OP || opcode==`BLZ_OP|| opcode==`JMP_OP || opcode==`JAL_OP) begin
					   case (opcode)
						   `BNE_OP: begin
						   			assign PCSource=1;
									assign PCWriteCond=1;
						   end
						   `BEQ_OP: begin
							       	assign PCSource=1;
									assign PCWriteCond=1;
						   end
						   `BGZ_OP: begin
							   		assign PCSource=1;
									assign PCWriteCond=1;
						   end
						   `BLZ_OP: begin
							   		assign PCSource=1;
									assign PCWriteCond=1;
						   end
						   `JMP_OP: begin
						   		assign PCSource=0;
								assign PCWrite=1;
						   end
						   `JAL_OP: begin
						   		assign PCSource=0;
								assign PCWrite=1;
						   end
					    endcase
					end
				end
			`MEM1: begin
				assign PCWriteCond=0;
				assign lorD=1;
				assign MemRead=0;
				assign MemWrite=0;
				assign MemtoReg=0;
				assign IRWrite=0;
				assign PCSource=0;
				assign ALUOp=0;
				assign ALUSrcB=0;
				assign ALUSrcA=0;
				assign RegWrite=0;
				assign isWrite=0;
				assign extendsignal=0;
				assign ALUoutWrite=0;
				assign WriteMUX=0;
			    case(opcode)
				   `SWD_OP: begin
				   	assign isWrite=1;
				   end
				   `LWD_OP: begin
				   	assign MemRead=1;
				   end
			   endcase
		    end
			`MEM2: begin
				assign PCWriteCond=0;
				assign lorD=1;
				assign MemtoReg=0;
				assign IRWrite=0;
				assign PCSource=0;
				assign ALUOp=0;
				assign ALUSrcB=0;
				assign ALUSrcA=0;
				assign RegWrite=0;
				assign extendsignal=0;
				assign ALUoutWrite=0;
			   	case(opcode)
				   	`SWD_OP: begin
				   		assign MemWrite=1;
				   	end
					`LWD_OP: begin
 				   		assign MDRWrite=1;
 				   	end
			   	endcase
			end
			`MEM4: begin
				assign PCWriteCond=0;
				assign lorD=0;
				assign MemRead=0;
				assign MemWrite=0;
				assign MemtoReg=0;
				assign IRWrite=0;
				assign PCSource=0;
				assign ALUOp=0;
				assign ALUSrcB=0;
				assign ALUSrcA=0;
				assign isWrite = 0;
				assign RegWrite=0;
				assign extendsignal=0;
				assign ALUoutWrite=0;
				assign MDRWrite=0;
			end
			`WB: begin
				assign PCWriteCond=0;
				assign lorD=0;
				assign MemRead=0;
				assign MemWrite=0;
				assign MemtoReg=0;
				assign IRWrite=0;
				assign PCSource=0;
				assign ALUOp=0;
				assign ALUSrcB=0;
				assign ALUSrcA=0;
				assign RegWrite=0;
				assign isWrite=0;
				assign extendsignal=0;
				assign ALUoutWrite=0;
				assign PCWrite=0;
				if(opcode==`ADI_OP || opcode==`ORI_OP || opcode==`LHI_OP) begin
				   	assign WriteMUX=2'b01;
				 	assign RegWrite=1;
 			   	end
 			   	else if(opcode==`BNE_OP || opcode==`BEQ_OP || opcode==`BGZ_OP || opcode==`BLZ_OP|| opcode==`JMP_OP);
 			   	else if(opcode==`JAL_OP) begin
			   		assign WriteMUX=2'b11;

					assign RegWrite=1;
 			   	end
 			   	else if(opcode==`LWD_OP)begin
					assign MemtoReg=2'b01;
				    assign WriteMUX=2'b01;
					assign RegWrite=1;
 			   	end
 			   	else if(opcode==`SWD_OP);
 			   	else begin
					if(func == `INST_FUNC_JPR || func == `INST_FUNC_HLT || func == `INST_FUNC_WWD);
 			   	   	else if(func == `INST_FUNC_JRL) begin
					   		assign WriteMUX=2'b11;
						 	assign RegWrite=1;
 					   	end
 					else begin
						assign WriteMUX=2'b10;
					 	assign RegWrite=1;
 				   	end
 			   	end
			end
		endcase
		State = NextState(State, opcode);
	end
endmodule
