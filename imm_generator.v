`include "opcodes.v"

module immediate_generator(
    data,

    sign_extended_target,
    sign_extended_8_imm, 
    zero_extended_8_imm
);

    input [`WORD_SIZE - 1:0] data;

    output [`WORD_SIZE - 1 : 0] sign_extended_target, sign_extended_8_imm, zero_extended_8_imm;

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

    assign sign_extended_8_imm = ARSN(LLSN(data, 8), 8);
    assign zero_extended_8_imm = LRSN(LLSN(data, 8), 8);
    assign sign_extended_target = ARSN(LLSN(data, 4), 4);

endmodule