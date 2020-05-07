`define WORD_SIZE 16    // data and address word size

module register(rs_num, rt_num, writenum, writedata, regwrite, rs_data, rt_data);
    input [1:0]rs_num;
    input [1:0]rt_num;
    input [1:0]writenum;
    input [`WORD_SIZE-1:0]writedata;
    input regwrite;

    output [`WORD_SIZE - 1:0]rs_data;
    output [`WORD_SIZE - 1:0]rt_data;

    wire [`WORD_SIZE - 1:0]rs_data;
    wire [`WORD_SIZE - 1:0]rt_data;
    reg [`WORD_SIZE - 1:0]regi[3:0];

    integer i;

    initial begin
            for (i = 0; i< 4; i = i + 1)begin
                regi[i] = 16'h0000;
            end
        end
    assign rs_data = regi[rs_num];
    assign rt_data = regi[rt_num];

    always @(posedge regwrite) begin
        regi[writenum] = writedata;
    end
endmodule
