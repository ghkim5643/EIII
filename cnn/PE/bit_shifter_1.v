`timescale 1ns / 1ps
module bit_shifter_1(
	input         clk,
	input         rst,
	input         i_skip,
	input  [3:0]  i_weight,
	input  [7:0]  i_activation,
	output [14:0] o_bit_shifted 
);

reg [13:0] r_bit_shifted;
reg        r_sign;

always @(posedge clk or posedge rst) begin

	if(rst) begin
		r_bit_shifted <= 14'd0;
		r_sign        <=  1'd0;
	end else begin
		if(i_skip) begin
			r_sign        <= r_sign;
			r_bit_shifted <= r_bit_shifted;
		end else begin
			case (i_weight [2:0]) // operate by i_weight excepting sign bit
				3'd1    : r_bit_shifted <= {6'd0, i_activation      };
				3'd2    : r_bit_shifted <= {5'd0, i_activation, 1'd0};
				3'd3    : r_bit_shifted <= {4'd0, i_activation, 2'd0};
				3'd4    : r_bit_shifted <= {3'd0, i_activation, 3'd0};
				3'd5    : r_bit_shifted <= {2'd0, i_activation, 4'd0};
				3'd6    : r_bit_shifted <= {1'd0, i_activation, 5'd0};
				3'd7    : r_bit_shifted <= {      i_activation, 6'd0};
				default : r_bit_shifted <= 14'd0;
			endcase

			r_sign <= (i_weight[3]) ? 1'd1 : 1'd0;
		end
	end
end

assign o_bit_shifted = (r_sign) ? {r_sign, ~(r_bit_shifted)} + 1'd1 : {r_sign, r_bit_shifted};

endmodule