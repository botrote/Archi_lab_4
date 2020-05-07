
// Opcode
`define	ALU_OP	4'd15
`define	ADI_OP	4'd4
`define	ORI_OP	4'd5
`define	LHI_OP	4'd6
`define	LWD_OP	4'd7
`define	SWD_OP	4'd8
`define	BNE_OP	4'd0
`define	BEQ_OP	4'd1
`define BGZ_OP	4'd2
`define BLZ_OP	4'd3
`define	JMP_OP	4'd9
`define JAL_OP	4'd10
`define	JPR_OP	4'd15
`define	JRL_OP	4'd15

// ALU Function Codes
`define	FUNC_ADD	3'b000
`define	FUNC_SUB	3'b001
`define	FUNC_AND	3'b010
`define	FUNC_ORR	3'b011
`define	FUNC_NOT	3'b100
`define	FUNC_TCP	3'b101
`define	FUNC_SHL	3'b110
`define	FUNC_SHR	3'b111

// ALU instruction function codes
`define INST_FUNC_ADD 6'd0
`define INST_FUNC_SUB 6'd1
`define INST_FUNC_AND 6'd2
`define INST_FUNC_ORR 6'd3
`define INST_FUNC_NOT 6'd4
`define INST_FUNC_TCP 6'd5
`define INST_FUNC_SHL 6'd6
`define INST_FUNC_SHR 6'd7
`define INST_FUNC_JPR 6'd25
`define INST_FUNC_JRL 6'd26
`define INST_FUNC_WWD 6'd28
`define INST_FUNC_HLT 6'd29

`define ALU_ADD 0
`define ALU_SUB 1
`define ALU_JMP 2
`define ALU_NOT 3
`define ALU_AND 4
`define ALU_OR 5
`define ALU_NAND 6
`define ALU_NOR 7
`define ALU_XOR 8
`define ALU_LLS 9
`define ALU_XNOR 10
`define ALU_LRS 11
`define ALU_ARS 12
`define ALU_TCP 13
`define ALU_EXT 14
`define ALU_ZERO 15
`define ALU_LLSN 18
`define ALU_LRSN 19
`define ALU_ARSN 20
`define ALU_LHI 21
`define ALU_BEQ 22
`define ALU_BNE 23
`define ALU_BLZ 24
`define ALU_BGZ 25



`define IF1 0
`define IF2 1
`define IF3 2
`define IF4 3
`define ID 4
`define EX1 5
`define EX2 6
`define MEM1 7
`define MEM2 8
`define MEM3 9
`define MEM4 10
`define WB 11

`define	WORD_SIZE	16
`define	NUM_REGS	4
