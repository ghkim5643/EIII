`timescale 1ns / 1ps

/*
-------------------------------------------------------
make fp32 to integer and change digit by unit' exponent 


-------------------------------------------------------
*/

module quant_pre(
    input         clk,
    input         rst,
    input  [31:0] i_max,
    input  [31:0] i_activation,
    output [31:0] o_unit,
    output [31:0] o_activation
);

    reg [31:0] r_unit;
    reg [31:0] r_activation;

    always@(posedge clk or posedge rst) begin
        if (rst) begin
		    r_unit       <= 32'd0;
			r_activation <= 32'd0;
        end else begin
            // if activation is bigger than max's exponent, return r_activation as 1111 1111
            if (i_activation[30:23] > i_max[30:23]) begin 
                r_unit <= 32'h80000000; 
                r_activation <= 32'hff000000; 

            // if activation is lower than unit's exponent, return 0
            end else if (i_activation[30:23] < (i_max[30:23] - 8'd8)) begin 
                r_unit <= 32'h00000008;
                r_activation <= 32'd0;
                
            // if max exp - act exp = 0~8
            end else begin
                r_unit <= {2'd1, i_max[22:0], 7'd0};
                
                case (i_max[30:23] - i_activation[30:23])
                    8'd8:    r_activation <= {9'd1, i_activation[22:0]};
                    8'd7:    r_activation <= {8'd1, i_activation[22:0], 1'd0};
                    8'd6:    r_activation <= {7'd1, i_activation[22:0], 2'd0};
                    8'd5:    r_activation <= {6'd1, i_activation[22:0], 3'd0};
                    8'd4:    r_activation <= {5'd1, i_activation[22:0], 4'd0};
                    8'd3:    r_activation <= {4'd1, i_activation[22:0], 5'd0};
                    8'd2:    r_activation <= {3'd1, i_activation[22:0], 6'd0};
                    8'd1:    r_activation <= {2'd1, i_activation[22:0], 7'd0};
                    default: r_activation <= {1'd1, i_activation[22:0], 8'd0};
                endcase
            end
        end
    end

    assign o_unit = r_unit;
    assign o_activation = r_activation;

endmodule