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
    RegWrite
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
    output ALUOp;
    output [1:0] ALUSrcB;
    output ALUSrcA;
    output RegWrite;

    reg [3:0] stage;
        parameter NON = -1;
        parameter IF_1 = 0, IF_2 = 1, IF_3 = 2, IF_4 = 3;
        parameter ID = 4;
        parameter EX_1 = 5, EX_2 = 6;
        parameter MEM_1 = 7, MEM_2 = 8, MEM_3 = 9, MEM_4 = 10;
        parameter WB_1 = 11;

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
                end

            `IF_2:
                begin

                end

            `IF_3:
                begin

                end

            `IF_4:
                begin
                
                end

