`timescale 1ns / 1ps
module quant_divider(
	input         clk,
	input         reset_n,
    input  [7:0]  i_index,
	input  [31:0] i_unit,
	input  [31:0] i_activation,
	output [7:0]  o_index,
	output [31:0] o_left,
	output [31:0] o_unit
);

    reg [7:0]  r_index;
    reg [31:0] r_left;
    reg [31:0] r_unit;

    always@(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            r_index <=  1'd0;
            r_left  <= 32'd0;
            r_unit  <= 32'd0;
        
        end else begin
            r_unit  <= {1'd0, i_unit[31:1]}; // right shift
            if ((i_activation == 32'd0) | (i_activation < i_unit)) begin 
                r_index <= {i_index[6:0], 1'd0};
                r_left  <= i_activation;

            end else begin
                r_index <= {i_index[6:0], 1'd1};
                r_left  <= i_activation - i_unit;
                
            end
        end
    end

assign o_index = r_index;
assign o_left  = r_left;
assign o_unit  = r_unit;

endmodule