`timescale 1ns / 1ps
module quantizer(
    input         clk,
    input         rst,
    input  [31:0] i_max,
    input  [31:0] i_activation,
    output [7:0]  o_index
);

    wire [7:0]  w_index[7:0];
    wire [31:0] w_left [7:0];
    wire [31:0] w_unit [7:0];

    quant_pre u_quant_pre(
        .clk(clk),
        .rst(rst),
        .i_max(i_max),
        .i_activation(i_activation),
        .o_unit(w_unit[0]),
        .o_activation(w_left[0])
    );

    quant_divider u_quant_divider_1 (
        .clk(clk), .rst(rst),
        .i_index(8'd0), .i_unit(w_unit[0]), .i_activation(w_left[0]), 
	    .o_index(w_index[0]), .o_left(w_left[1]), .o_unit(w_unit[1])
    );
    quant_divider u_quant_divider_2 (
        .clk(clk), .rst(rst),
        .i_index(w_index[0]), .i_unit(w_unit[1]), .i_activation(w_left[1]), 
	    .o_index(w_index[1]), .o_left(w_left[2]), .o_unit(w_unit[2])
    );
    quant_divider u_quant_divider_3 (
        .clk(clk), .rst(rst),
        .i_index(w_index[1]), .i_unit(w_unit[2]), .i_activation(w_left[2]), 
	    .o_index(w_index[2]), .o_left(w_left[3]), .o_unit(w_unit[3])
    );
    quant_divider u_quant_divider_4 (
        .clk(clk), .rst(rst),
        .i_index(w_index[2]), .i_unit(w_unit[3]), .i_activation(w_left[3]), 
	    .o_index(w_index[3]), .o_left(w_left[4]), .o_unit(w_unit[4])
    );
    quant_divider u_quant_divider_5 (
        .clk(clk), .rst(rst),
        .i_index(w_index[3]), .i_unit(w_unit[4]), .i_activation(w_left[4]), 
	    .o_index(w_index[4]), .o_left(w_left[5]), .o_unit(w_unit[5])
    );
    quant_divider u_quant_divider_6 (
        .clk(clk), .rst(rst),
        .i_index(w_index[4]), .i_unit(w_unit[5]), .i_activation(w_left[5]), 
	    .o_index(w_index[5]), .o_left(w_left[6]), .o_unit(w_unit[6])
    );
    quant_divider u_quant_divider_7 (
        .clk(clk), .rst(rst),
        .i_index(w_index[5]), .i_unit(w_unit[6]), .i_activation(w_left[6]), 
	    .o_index(w_index[6]), .o_left(w_left[7]), .o_unit(w_unit[7])
    );
    quant_divider u_quant_divider_8 (
        .clk(clk), .rst(rst),
        .i_index(w_index[6]), .i_unit(w_unit[7]), .i_activation(w_left[7]), 
	    .o_index(w_index[7]), .o_left(), .o_unit()
    );

    assign o_index = w_index[7];

endmodule