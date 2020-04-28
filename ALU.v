`include "opcodes.v"

module alu( 
    funcCode,  
    op1, 
    op2, 

    aResult, 
    bResult
);

    input [3:0] funcCode;
    input [`WORD_SIZE-1:0] op1;
    input [`WORD_SIZE-1:0] op2;

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
        `FUNC_ADD : assign aResult = op1 + op2;
        `FUNC_SUB : assign aResult = op1 - op2;
        `FUNC_AND : assign aResult = op1 & op2;
        `FUNC_ORR : assign aResult = op1 | op2;
        `FUNC_NOT : assign aResult = ~op1;
        `FUNC_TCP : assign aResult = ~op1 + 1;
        `FUNC_SHL : assign aResult = op1 << 1;
        `FUNC_SHR : assign aResult = ($signed(op1) >>> 1);	
        `FUNC_BNE : assign bResult = ((op1 == op2) ? 0 : 1);
        `FUNC_BEQ : assign bResult = ((op1 == op2) ? 1 : 0);
        `FUNC_BGZ : assign bResult = ((op1 > 0) ? 1 : 0);
        `FUNC_BLZ : assign bResult = ((op1 < 0) ? 1 : 0);
        endcase
    end

endmodule