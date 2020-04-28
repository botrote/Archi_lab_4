`include "opcodes.v"

module ALU(op1, op2, funcCode, aResult, bResult);

    input [`WORD_SIZE-1:0] op1;
    input [`WORD_SIZE-1:0] op2;
    input [4:0] funcCode;

    output [`WORD_SIZE-1:0] aResult;
    output bResult;

    reg [`WORD_SIZE-1:0] aResult;
    reg bResult;

    initial begin
        aResult = 0;
        bResult = 0;
    end

    always @(*) begin

        case(funcCode) 
        `ALU_ADD : assign aResult = op1 + op2;
        `ALU_SUB : assign aResult = op1 - op2;
        `ALU_AND : assign aResult = op1 & op2;
        `ALU_ORR : assign aResult = op1 | op2;
        `ALU_NOT : assign aResult = ~op1;
        `ALU_TCP : assign aResult = ~op1 + 1;
        `ALU_SHL : assign aResult = op1 << 1;
        `ALU_SHR : assign aResult = ($signed(op1) >>> 1);	
        `ALU_BNE : assign bResult = ((op1 == op2) ? 0 : 1);
        `ALU_BEQ : assign bResult = ((op1 == op2) ? 1 : 0);
        `ALU_BGZ : assign bResult = ((op1 > 0) ? 1 : 0);
        `ALU_BLZ : assign bResult = ((op1 < 0) ? 1 : 0);
        endcase
    end

endmodule