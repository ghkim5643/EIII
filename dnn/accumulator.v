`timescale 1ns / 1ps
module accumulator(
    input         clk,
    input         reset_n,
    input         i_skip,
    input  [31:0] i_bit_shifted,
    output [31:0] o_accumulated
);

reg [31:0] r_accumulated;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        r_accumulated <= 32'd0; //check bit
    end else begin
        if (i_skip) begin
            r_accumulated <= r_accumulated;
        end else begin
            r_accumulated <= i_bit_shifted + r_accumulated;
        end
    end
end

assign o_accumulated = r_accumulated;

endmodule