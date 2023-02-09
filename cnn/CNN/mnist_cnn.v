module mnist_cnn(
	clk, rst, in_data_unquant, in_data_max, 
	
	in_weight1_1_1unq, in_weight1_1_2unq, in_weight1_1_3unq,
	
	in_weight2_1_1unq, in_weight2_1_2unq, in_weight2_1_3unq,
	in_weight2_2_1unq, in_weight2_2_2unq, in_weight2_2_3unq,
	in_weight2_3_1unq, in_weight2_3_2unq, in_weight2_3_3unq,
	
	in_bias_1, in_bias_2,
	
	decision, valid_out
);

input clk, rst;
input [31:0] in_data_unquant;
input [31:0] in_data_max;
input [31:0] in_weight1_1_1unq, in_weight1_1_2unq, in_weight1_1_3unq,
             in_weight2_1_1unq, in_weight2_1_2unq, in_weight2_1_3unq,
	         in_weight2_2_1unq, in_weight2_2_2unq, in_weight2_2_3unq,
	         in_weight2_3_1unq, in_weight2_3_2unq, in_weight2_3_3unq;
	         
input [31:0] in_bias_1;
input [31:0] in_bias_2;

output [3:0] decision;
output valid_out;

wire signed [11:0] conv_out_1, conv_out_2, conv_out_3;
wire signed [11:0] max_value_1, max_value_2, max_value_3;
wire signed [11:0] conv2_out_1, conv2_out_2, conv2_out_3;
wire signed [11:0] max_value2_1, max_value2_2, max_value2_3;
wire signed [11:0] fc_out_data;
wire [7:0] in_data;
wire valid_out_1, valid_out_2, valid_out_3, valid_out_4, valid_out_5;
wire signed [3:0] o_weight1_1_1, o_weight1_1_2, o_weight1_1_3, 
                  o_weight2_1_1, o_weight2_1_2, o_weight2_1_3, 
                  o_weight2_2_1, o_weight2_2_2, o_weight2_2_3,
                  o_weight2_3_1, o_weight2_3_2, o_weight2_3_3;
  
wire signed [7:0] bias_1, bias_2;

quantizer quant_act(clk, rst, in_data_max, in_data_unquant, in_data);

weight_quantizer layer1_1_1(clk, rst, in_weight1_1_1unq, o_weight1_1_1);
weight_quantizer layer1_1_2(clk, rst, in_weight1_1_2unq, o_weight1_1_2);
weight_quantizer layer1_1_3(clk, rst, in_weight1_1_3unq, o_weight1_1_3);

weight_quantizer layer2_1_1(clk, rst, in_weight2_1_1unq, o_weight2_1_1);
weight_quantizer layer2_1_2(clk, rst, in_weight2_1_2unq, o_weight2_1_2);
weight_quantizer layer2_1_3(clk, rst, in_weight2_1_3unq, o_weight2_1_3);
weight_quantizer layer2_2_1(clk, rst, in_weight2_2_1unq, o_weight2_2_1);
weight_quantizer layer2_2_2(clk, rst, in_weight2_2_2unq, o_weight2_2_2);
weight_quantizer layer2_2_3(clk, rst, in_weight2_2_3unq, o_weight2_2_3);
weight_quantizer layer2_3_1(clk, rst, in_weight2_3_1unq, o_weight2_3_1);
weight_quantizer layer2_3_2(clk, rst, in_weight2_3_2unq, o_weight2_3_2);
weight_quantizer layer2_3_3(clk, rst, in_weight2_3_3unq, o_weight2_3_3);

converter int_bias_1(clk, rst, in_bias_1, bias_1);
converter int_bias_2(clk, rst, in_bias_2, bias_2);

conv_5ks_1 conv_5ks_1(
	clk, rst, in_data, o_weight1_1_1, o_weight1_1_2, o_weight1_1_3, bias_1,
	
	conv_out_1, conv_out_2, conv_out_3,
	valid_out_1
);

mxp_relu #(.CONV_BIT(12), .HALF_WIDTH(12), .HALF_HEIGHT(12), .HALF_WIDTH_BIT(4)) 
mxp_relu_1(
    clk, rst,
    valid_out_1,
    conv_out_1, conv_out_2, conv_out_3,
	
    max_value_1, max_value_2, max_value_3,
    valid_out_2
);

conv_5ks_2 conv_5ks_2(
	clk, rst, valid_out_2,
	max_value_1, max_value_2, max_value_3,
	
	conv2_out_1, conv2_out_2, conv2_out_3,
	valid_out_3
);

mxp_relu #(.CONV_BIT(12), .HALF_WIDTH(4), .HALF_HEIGHT(4), .HALF_WIDTH_BIT(3)) 
mxp_relu_2(
    clk, rst,
    valid_out_3,
    conv2_out_1, conv2_out_2, conv2_out_3,
	
    max_value2_1, max_value2_2, max_value2_3,
    valid_out_4
);

fc_layer #(.NUM_INPUT_DATA(48), .NUM_OUTPUT_DATA(10))
fc_layer(
    clk, rst, valid_out_4,
    max_value2_1,
    max_value2_2,
    max_value2_3,

    valid_out_5,
    fc_out_data
);

comparator #(.INPUT_BITS(12), .NUM_CLASS(10))
comparator(
    clk, rst,
    valid_out_5,
    fc_out_data,
			   
    decision,
	valid_out
);  

endmodule
