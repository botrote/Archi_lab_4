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
        `FUNC_ADD : 
		begin
			assign aResult = op1 + op2;
			$display("op1: %d + op2: %d = aResult: %d", op1, op2, aResult);
		end
        `FUNC_SUB : 
		begin
			assign aResult = op1 - op2;
			$display("op1: %d - op2: %d = aResult: %d", op1, op2, aResult);
		end
        `FUNC_AND : 
		begin
			assign aResult = op1 & op2;
		end
        `FUNC_ORR : assign aResult = op1 | op2;
        `FUNC_NOT : assign aResult = ~op1;
        `FUNC_TCP : assign aResult = ~op1 + 1;
        `FUNC_SHL : assign aResult = op1 << 1;
        `FUNC_SHR : assign aResult = ($signed(op1) >>> 1);	
        `FUNC_BNE : assign bResult = ((op1 == op2) ? 0 : 1);
        `FUNC_BEQ : assign bResult = ((op1 == op2) ? 1 : 0);
        `FUNC_BGZ : assign bResult = ((op1 > 0) ? 1 : 0);
        `FUNC_BLZ : assign bResult = ((op1 < 0) ? 1 : 0);


        `FUNC_LHI:
            begin
                assign aResult = op2 << 8;
            end
        endcase
    end

endmodule