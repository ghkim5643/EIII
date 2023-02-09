`timescale 1ns / 1ps
module weight_quantizer(
	input         clk,
	input         rst,
	input  [31:0] i_weight,
	output [3:0]  o_index
);

reg        r_sign;
reg [2:0]  r_index;

always@(posedge clk or posedge rst) begin
	if(rst) begin
		r_index <= 3'd0;
	end else begin
		if(i_weight[30:23] <= 8'd123) begin       
			r_index <= 3'd0;
		end else if(i_weight[30:23] >= 8'd130) begin 
			r_index <= 3'd7;
		end else begin                           
			case(i_weight[30:23])
				8'd124  : r_index <= 3'd1;
				8'd125  : r_index <= 3'd2;
				8'd126  : r_index <= 3'd3;
				8'd127  : r_index <= 3'd4;
				8'd128  : r_index <= 3'd5;
				default : r_index <= 3'd6;
			endcase
		end
		r_sign  <= i_weight[31]; 			
	end
end

assign o_index = {r_sign, r_index};

endmodule