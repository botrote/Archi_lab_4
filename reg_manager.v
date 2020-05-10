`include "opcodes.v"

module Reg_Manager(r1Idx, r2Idx, writeM, writeIdx, writeData, r1Data, r2Data);

    input [1 : 0] r1Idx;
    input [1 : 0] r2Idx; 

    input writeM;
    input [1 : 0] writeIdx;
    input [`WORD_SIZE - 1 : 0] writeData;

    output [`WORD_SIZE - 1 : 0] r1Data;
    output [`WORD_SIZE - 1 : 0] r2Data;

    reg [`WORD_SIZE - 1 : 0] registers [`NUM_REGS - 1:0];

    assign r1Data = registers[r1Idx];
    assign r2Data = registers[r2Idx];

    initial begin
        registers[0] = 0;
        registers[1] = 0;
        registers[2] = 0;
        registers[3] = 0;
    end

    always @(writeM) begin
        if(writeM == 1)
            registers[writeIdx] = writeData;

        //$display("Register Content");
        //$display("Register 0:      %d", registers[0]);
        //$display("Register 1:      %d", registers[1]);
        //$display("Register 2:      %d", registers[2]);
        //$display("Register 3:      %d", registers[3]);
    end

endmodule