`timescale 1ns / 1ps
module pe(
    input         clk,
    input         reset_n,
    input  [3:0]  i_weight,
    input  [7:0]  i_activation,
    output [31:0] o_calculated
);


wire        w_skip;
wire [31:0] w_bit_shifted;

assign w_skip  = ((!(i_activation[0]|
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


bit_shifter u_bit_shifter(
    .clk           (clk),
   .reset_n       (reset_n),
   .i_weight      (i_weight),
   .i_activation  (i_activation),
   .o_bit_shifted (w_bit_shifted)
);

accumulator u_accumulator(
    .clk           (clk),
    .reset_n       (reset_n),
    .i_bit_shifted (w_bit_shifted),
    .o_accumulated (o_calculated)
);

endmodule