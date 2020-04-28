`include "opcode.v"

module control_unit(
    clk,
    opcode,
    func,

    PCWriteCond,
    PCWrite,
    IorD,
    MemRead,
    MemWrite,
    MemtoReg,
    IRWrite,
    PCSource,
    ALUOp,
    ALUSrcB,
    ALUSrcA,
    RegWrite,

    RegDst,
    InstFlag,
    ImmGenSig
)

    input [3:0] opcode;
    input [5:0] func;

    output PCWriteCond;
    output PCWrite;
    output IorD;
    output MemRead;
    output MemWrite;
    output MemtoReg;
    output IRWrite;
    output PCSource;
    output [3:0] ALUOp;
    output [1:0] ALUSrcB;
    output ALUSrcA;
    output RegWrite;

    output [1:0] RegDst;
    output InstFlag;
    output [1:0] ImmGenSig;

    reg [3:0] stage;
        parameter NON = -1;
        parameter IF_1 = 0, IF_2 = 1, IF_3 = 2, IF_4 = 3;
        parameter ID = 4;
        parameter EX_1 = 5, EX_2 = 6;
        parameter MEM_1 = 7, MEM_2 = 8, MEM_3 = 9, MEM_4 = 10;
        parameter WB = 11;

    initial begin
        assign PCWriteCond = 0;
        assign PCWrite = 0;
        assign IorD = 0;
        assign MemRead = 0;
        assign MemWrite = 0;
        assign MemtoReg = 0;
        assign IRWrite = 0;
        assign PCSource = 0;
        assign ALUOp = 0;
        assign ALUSrcB = 2'b00;
        assign ALUSrcA = 0;
        assign RegWrite = 0;
    end

    always @(posedge clk) begin
        case(stage)
            `IF_1: 
                begin
                    assign PCWriteCond = 0;
                    assign PCWrite = 0;
                    assign IorD = 0;
                    assign MemRead = 1;
                    assign MemWrite = 0;
                    assign MemtoReg = 0;
                    assign IRWrite = 0;
                    assign PCSource = 0;
                    assign ALUOp =                          // not fin
                    assign ALUSrcB =                        // not fin
                    assign ALUSrcA =                        // not fin
                    assign RegWrite = 0;
                end

            `IF_2:
                begin
                    assign PCWriteCond = 0;
                    assign PCWrite = 0;
                    assign IorD = 0;
                    assign MemRead = 1;
                    assign MemWrite = 0;
                    assign MemtoReg = 0;
                    assign IRWrite = 0;
                    assign PCSource = 0;
                    assign ALUOp =                          // not fin
                    assign ALUSrcB =                        // not fin
                    assign ALUSrcA =                        // not fin

                end

            `IF_3:
                begin
                    assign PCWriteCond = 0;
                    assign PCWrite = 0;
                    assign IorD = 0;
                    assign MemRead = 1;
                    assign MemWrite = 0;
                    assign MemtoReg = 0;
                    assign IRWrite = 1;
                    assign PCSource = 0;
                    assign ALUOp = ;                        // not fin
                    assign ALUSrcB = ;                      // not fin
                    assign ALUSrcA = ;                      // not fin
                end

            `IF_4:
                begin
                    assign PCWriteCond = 0;
                    assign PCWrite = 0;
                    assign IorD = 0;
                    assign MemRead = 1;
                    assign MemWrite = 0;
                    assign MemtoReg = 0;
                    assign IRWrite = 1;
                    assign PCSource = 0;
                    assign ALUOp = ;                        // not fin
                    assign ALUSrcB = ;                      // not fin
                    assign ALUSrcA = ;                      // not fin
                end

            `ID:
                begin
                    assign PCWriteCond = 0;
                    assign PCWrite = 0;
                    assign IorD = 0;
                    assign MemRead = 1;
                    assign MemWrite = 0;
                    assign MemtoReg = 0;
                    assign IRWrite = 1;
                    assign PCSource = 0;
                    assign ALUOp = ;                        // not fin
                    assign ALUSrcB = ;                      // not fin
                    assign ALUSrcA = ;                      // not fin
                end

            `EX_1:
                begin
                    assign PCWriteCond = 0;
                    assign PCWrite = 0;
                    assign IorD = 0;
                    assign MemRead = 1;
                    assign MemWrite = 0;
                    assign MemtoReg = 0;
                    assign IRWrite = 1;
                    assign PCSource = 0;
                    assign ALUOp = ;                        // not fin
                    assign ALUSrcB = ;                      // not fin
                    assign ALUSrcA = ;                      // not fin

                    if(opcode == `ALU_OP) 
                        begin
                            assign ALUSrcB = ;
                            assign ALUSrcA = ;

                            case(func)
                                `INST_FUNC_ADD: 
                                    begin
                                        assign ALUOp = `FUNC_ADD;
                                    end

                                `INST_FUNC_SUB:
                                    begin
                                        assign ALUOp = `FUNC_SUB;
                                    end

                                `INST_FUNC_AND:
                                    begin
                                        assign ALUOp = `FUNC_AND;
                                    end

                                `INST_FUNC_ORR:
                                    begin
                                        assign ALUOp = `FUNC_ORR;
                                    end

                                `INST_FUNC_NOT:
                                    begin
                                        assign ALUOp = `FUNC_NOT;
                                    end

                                `INST_FUNC_TCP:
                                    begin
                                        assign ALUOp = `FUNC_TCP;
                                    end

                                `INST_FUNC_SHL:
                                    begin
                                        assign ALUOp = `FUNC_SHL;
                                    end

                                `INST_FUNC_SHR:
                                    begin
                                        assign ALUOp = `FUNC_SHR;
                                    end

                                `INST_FUNC_JPR:
                                    begin
                                        assign ALUOp = `FUNC_ADD;
                                    end

                                `INST_FUNC_JRL:
                                    begin
                                        assign ALUOp = `FUNC_ADD;
                                    end

                                `INST_FUNC_WWD:
                                    begin
                                        assign ;                                    // not fin
                                    end

                                `INST_FUNC_HLT:
                                    begin
                                        assign ;                                    // not fin
                                    end
                            endcase
                        end

                    case(opcode)
                        `ADI_OP:
                            begin
                                assign ALUOp = `FUNC_ADD;
                                assign ALUSrcB = 2b'10;
                                assign ALUSrcA = 1;
                            end

                        `ORI_OP:
                            begin
                                assign ALUOp = `FUNC_ORR;
                                assign ALUSrcB = 2b'10;
                                assign ALUSrcA = 1;
                            end

                        `LHI_OP:
                            begin
                                assign ALUOp = `FUNC_;                  // not fin
                                assign ALUSrcB = 2b'10;
                                assign ALUSrcA = 1;
                            end

                        `LWD_OP:
                            begin
                                assign ALUOp = `FUNC_ADD;
                                assign ALUSrcB = 2b'10;
                                assign ALUSrcA = 1;
                            end

                        `SWD_OP:
                            begin
                                assign ALUOp = `FUNC_ADD;
                                assign ALUSrcB = 2b'10;
                                assign ALUSrcA = 1;
                            end

                        `BNE_OP:
                            begin
                                assign ALUOp = `FUNC_BNE;
                                assign ALUSrcB = 2b'10;
                                assign ALUSrcA = 1;
                            end

                        `BEQ_OP:
                            begin
                                assign ALUOp = `FUNC_BEQ;
                                assign ALUSrcB = 2b'10;
                                assign ALUSrcA = 1;
                            end

                        `BGZ_OP:
                            begin
                                assign ALUOp = `FUNC_BGZ;
                                assign ALUSrcB = 2b'10;
                                assign ALUSrcA = 1;
                            end

                        `BLZ_OP:
                            begin
                                assign ALUOp = `FUNC_BLZ;
                                assign ALUSrcB = 2b'10;
                                assign ALUSrcA = 1;
                            end

                        `JMP_OP:
                            begin
                                assign ALUOp = `FUNC_;
                                assign ALUSrcB = 2b'10;
                                assign ALUSrcA = 1;
                            end

                        `JAL_OP:
                            begin
                                assign ALUOp = `FUNC_ADD;
                                assign ALUSrcB = 2b'10;
                                assign ALUSrcA = 1;
                            end
                    endcase
                end

            `EX_2:
                begin
                    assign PCWriteCond = 0;
                    assign PCWrite = 0;
                    assign IorD = 0;
                    assign MemRead = 1;
                    assign MemWrite = 0;
                    assign MemtoReg = 0;
                    assign IRWrite = 1;
                    assign PCSource = 0;
                    assign ALUOp = ;                        // not fin
                    assign ALUSrcB = ;                      // not fin
                    assign ALUSrcA = ;                      // not fin
                end

            `MEM_1:
                begin
                    assign PCWriteCond = 0;
                    assign PCWrite = 0;
                    assign IorD = 0;
                    assign MemRead = 1;
                    assign MemWrite = 0;
                    assign MemtoReg = 0;
                    assign IRWrite = 1;
                    assign PCSource = 0;
                    assign ALUOp = ;                        // not fin
                    assign ALUSrcB = ;                      // not fin
                    assign ALUSrcA = ;                      // not fin

                    if(opcode == `LWD_OP)
                        begin
                            assign MemRead = 1; 
                        end

                    if(opcode == `SWD_OP)
                        begin
                            assign
                        end
                end

            `MEM_2:
                begin
                    assign PCWriteCond = 0;
                    assign PCWrite = 0;
                    assign IorD = 0;
                    assign MemRead = 1;
                    assign MemWrite = 0;
                    assign MemtoReg = 0;
                    assign IRWrite = 1;
                    assign PCSource = 0;
                    assign ALUOp = ;                        // not fin
                    assign ALUSrcB = ;                      // not fin
                    assign ALUSrcA = ;                      // not fin

                    if(opcode == `LWD_OP)
                        begin
                            assign ; 
                        end

                    if(opcode == `SWD_OP)
                        begin
                            assign MemWrite = 1;
                        end
                end

            `MEM_3:
                begin
                    assign PCWriteCond = 0;
                    assign PCWrite = 0;
                    assign IorD = 0;
                    assign MemRead = 1;
                    assign MemWrite = 0;
                    assign MemtoReg = 0;
                    assign IRWrite = 1;
                    assign PCSource = 0;
                    assign ALUOp = ;                        // not fin
                    assign ALUSrcB = ;                      // not fin
                    assign ALUSrcA = ;                      // not fin
                end

            `MEM_4:
                begin
                    assign PCWriteCond = 0;
                    assign PCWrite = 0;
                    assign IorD = 0;
                    assign MemRead = 1;
                    assign MemWrite = 0;
                    assign MemtoReg = 0;
                    assign IRWrite = 1;
                    assign PCSource = 0;
                    assign ALUOp = ;                        // not fin
                    assign ALUSrcB = ;                      // not fin
                    assign ALUSrcA = ;                      // not fin
                end

            `WB:
                begin
                    assign PCWriteCond = 0;
                    assign PCWrite = 0;
                    assign IorD = 0;
                    assign MemRead = 1;
                    assign MemWrite = 0;
                    assign MemtoReg = 0;
                    assign IRWrite = 1;
                    assign PCSource = 0;
                    assign ALUOp = ;                        // not fin
                    assign ALUSrcB = ;                      // not fin
                    assign ALUSrcA = ;                      // not fin


                end

        endcase


        // update stage
        if(stage == `IF_4 && opcode == `JAL_OP)
            begin
                stage = `EX_1;
            end
        else if(stage == `EX_2 && (opcode == `LWD_OP || opcode == `SWD_OP))
            begin
                stage = `MEM_1;
            end
        else if(stage == `EX_2 && (opcode == `BEQ_OP || opcode == `BGZ_OP || opcode == `BLZ_OP || opcode == `BNE_OP))
            begin
                stage = `IF_1;
            end
        else if(stage == `EX_2 && opcode == `ALU_OP || opcode == `ADI_OP || opcode == `ORI_OP || opcode == `LHI_OP || opcode == `JAL_OP) // see if it's all
            begin
                stage = `WB;
            end
        else if(stage == `MEM_4 && opcode == `LWD_OP)
            begin
                stage = `WB;
            end
        else if(stage == `MEM_4 && opcode == `SWD_OP)
            begin
                stage = `IF_1;
            end
        else
            begin
                if(stage == `WB)
                    begin
                        stage = `IF_1;
                    end
                else
                    begin
                        stage = stage + 1;
                    end
            end

endmodule