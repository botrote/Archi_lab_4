`include "opcodes.v"

module ImmGen(data, z8imm, s8imm, s12imm);
    input [`WORD_SIZE - 1 : 0]data;
    output [`WORD_SIZE - 1 : 0]z8imm;
    output [`WORD_SIZE - 1 : 0]s8imm;
    output [`WORD_SIZE - 1 : 0]s12imm;

    integer i;
    function [`WORD_SIZE-1:0]ARSN;
        input [`WORD_SIZE-1:0]A;
        input [`WORD_SIZE-1:0]B;
        begin
            for(i = 0; i < B; i = i + 1) begin
                if(A[`WORD_SIZE-1]==1)
                    A = ((A>>1)+16'h8000);
                else
                    A = (A>>1);
            end
            ARSN = A;
        end
    endfunction

    function [`WORD_SIZE-1:0]LRSN;
        input [`WORD_SIZE-1:0]A;
        input [`WORD_SIZE-1:0]B;
        begin
            A=(A>>B);
            LRSN = A;
        end
    endfunction

    function [`WORD_SIZE-1:0]LLSN;
        input [`WORD_SIZE-1:0]A;
        input [`WORD_SIZE-1:0]B;
        begin
            A = (A<<B);
            LLSN = A;
        end
    endfunction

    assign z8imm = LRSN(LLSN(data, 8), 8);
    assign s8imm = ARSN(LLSN(data, 8), 8);
    assign s12imm = ARSN(LLSN(data, 4), 4);

endmodule
