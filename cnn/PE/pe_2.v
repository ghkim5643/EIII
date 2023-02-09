`timescale 1ns / 1ps
module pe_2(
	input         clk,
    input         rst,
    input  [3:0]  i_weight,
    input  [11:0] i_activation,
    output [18:0] o_calculated
);

wire   w_skip;

assign w_skip    = ((!(i_activation[0]|
                       i_activation[1]|
                       i_activation[2]|
                       i_activation[3]|
                       i_activation[4]|
                       i_activation[5]|
                       i_activation[6]|
                       i_activation[7])) |

                   (!(i_weight[0]|
                      i_weight[1]|
                      i_weight[2]|
                      i_weight[3])));


bit_shifter_2 u_bit_shifter_2(
    .clk           (clk),
	.rst           (rst),
    .i_skip        (w_skip), 
	.i_weight      (i_weight),
	.i_activation  (i_activation),
	.o_bit_shifted (o_calculated)
);

endmodule