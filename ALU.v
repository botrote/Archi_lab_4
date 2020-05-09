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

    always @(funcCode) begin

        case(funcCode) 
        `FUNC_ADD : 
		begin
			assign aResult = op1 + op2;
			$display("%d + %d = %d", op1, op2, aResult);
		end
        `FUNC_SUB : 
		begin
			assign aResult = op1 - op2;
			$display("%d - %d = %d", op1, op2, aResult);
		end
        `FUNC_AND : 
		begin
			assign aResult = op1 & op2;
            $display("%d & %d = %d", op1, op2, aResult);
		end
        `FUNC_ORR :
            begin
                assign aResult = op1 | op2;
                $display("%d | %d = %d", op1, op2, aResult);
            end
        `FUNC_NOT : 
            begin
                assign aResult = ~op1;
                $display("~%d = %d", op1, aResult);
            end
        `FUNC_TCP : 
            begin
                assign aResult = ~op1 + 1;
                $display("~%d + 1 = %d", op1, aResult);
            end
        `FUNC_SHL : 
            begin
                assign aResult = op1 << 1;
                $display("%d << 1 = %d", op1, aResult);
            end
        `FUNC_SHR : 
            begin
                assign aResult = ($signed(op1) >>> 1);	
                $display("%d >> 1 = %d", op1, aResult);
            end
        `FUNC_BNE : 
            begin
                assign bResult = ((op1 == op2) ? 0 : 1);
                $display("%d %d => %d", op1, op2, bResult);
            end
        `FUNC_BEQ : 
            begin
                assign bResult = ((op1 == op2) ? 1 : 0);
                //$display("%d %d => %d", op1, op2, bResult);
            end
        `FUNC_BGZ : 
            begin
                assign bResult = ((op1 > 0) ? 1 : 0);
                //$display("%d %d => %d", op1, op2, bResult);
            end
        `FUNC_BLZ : 
            begin
                assign bResult = ((op1 < 0) ? 1 : 0);
                //$display("%d %d => %d", op1, op2, bResult);
            end


        `FUNC_LHI:
            begin
                assign aResult = op2 << 8;
                //$display("%d << 8 = %d", op2, aResult);
            end

        `FUNC_JMP:
            begin
                assign aResult = (op1 & 16'hf000) | op2;
            end

        endcase
    end

endmodule