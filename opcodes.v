		  
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
`define	FUNC_ADD	4'b0000
`define	FUNC_SUB	4'b0001				 
`define	FUNC_AND	4'b0010
`define	FUNC_ORR	4'b0011								    
`define	FUNC_NOT	4'b0100
`define	FUNC_TCP	4'b0101
`define	FUNC_SHL	4'b0110
`define	FUNC_SHR	4'b0111

// additional function codes for ALU
`define FUNC_BNE    4'b1000
`define FUNC_BEQ    4'b1001
`define FUNC_BLZ    4'b1010
`define FUNC_BGZ    4'b1011

// more additional function codes for ALU
`define FUNC_LHI    4'b1100
`define FUNC_JMP    4'b1101

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

// additional ALU instruction function codes
`define INST_FUNC_WWD 6'd28
`define INST_FUNC_HLT 6'd29

`define	WORD_SIZE	16			
`define	NUM_REGS	4