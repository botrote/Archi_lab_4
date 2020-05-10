`include "opcodes.v"

module immediate_generator(
    imm,
    target_address,

    sign_extended_target,
    sign_extended_8_imm, 
    zero_extended_8_imm
);

    input [7:0] imm;
    input [11:0] target_address;

    output reg [`WORD_SIZE - 1 : 0] sign_extended_target, sign_extended_8_imm, zero_extended_8_imm;

    integer i;
    always @(*)
        begin
            sign_extended_target = (target_address | 16'h0000) << 8;
            for(i = 0; i < 8; i = i + 1)
                begin
                    if(sign_extended_target[15] == 1)
                        sign_extended_target = (sign_extended_target >> 1) + 16'h8000;
                    else
                        sign_extended_target = sign_extended_target >> 1;
                end
            
            sign_extended_8_imm = (imm | 16'h0000) << 8;
            for(i = 0; i < 8; i = i + 1)
                begin
                    if(sign_extended_8_imm[15] == 1)
                        sign_extended_8_imm = (sign_extended_8_imm >> 1) + 16'h8000;
                    else
                        sign_extended_8_imm = sign_extended_8_imm >> 1;
                end

            zero_extended_8_imm = imm | 16'h0000;
        end

endmodule