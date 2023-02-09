module conv_5ks_1(
	clk, rst, in_data, in_weight_1,in_weight_2, in_weight_3, in_bias,
	
	conv_out_1, conv_out_2, conv_out_3,
	valid_out_2
);

input clk, rst;
input [7:0] in_data; //input data는 28x28개 있어야 되는거 아닌가? 8bit짜리 하나?
input [3:0] in_weight_1, in_weight_2, in_weight_3;
input [7:0] in_bias;

wire [7:0] out_data_0, out_data_1, out_data_2, out_data_3, out_data_4,
	out_data_5, out_data_6, out_data_7, out_data_8, out_data_9,
	out_data_10, out_data_11, out_data_12, out_data_13, out_data_14,
	out_data_15, out_data_16, out_data_17, out_data_18, out_data_19,
	out_data_20, out_data_21, out_data_22, out_data_23, out_data_24;
	
wire [3:0] out_weight_0, out_weight_1,out_weight_2,out_weight_3,out_weight_4,out_weight_5,out_weight_6,
           out_weight_7,out_weight_8,out_weight_9,out_weight_10,out_weight_11,out_weight_12,out_weight_13,
           out_weight_14,out_weight_15,out_weight_16,out_weight_17,out_weight_18,out_weight_19,out_weight_20,
           out_weight_21,out_weight_22,out_weight_23,out_weight_24,out_weight_25,out_weight_26,out_weight_27,
           out_weight_28,out_weight_29,out_weight_30,out_weight_31,out_weight_32,out_weight_33,out_weight_34,
           out_weight_35,out_weight_36,out_weight_37,out_weight_38,out_weight_39,out_weight_40,out_weight_41,
           out_weight_42,out_weight_43,out_weight_44,out_weight_45,out_weight_46,out_weight_47,out_weight_48,
           out_weight_49,out_weight_50,out_weight_51,out_weight_52,out_weight_53,out_weight_54,out_weight_55,
           out_weight_56,out_weight_57,out_weight_58,out_weight_59,out_weight_60,out_weight_61,out_weight_62,
           out_weight_63,out_weight_64,out_weight_65,out_weight_66,out_weight_67,out_weight_68,out_weight_69,
           out_weight_70,out_weight_71,out_weight_72,out_weight_73,out_weight_74;
    
wire [7:0] bias_0, bias_1, bias_2;    
	
wire valid_out_1;
 
output [11:0] conv_out_1, conv_out_2, conv_out_3;

output valid_out_2;

conv_buf_5ks #(.WIDTH(28), .HEIGHT(28), .DATA_BIT(8)) 
conv_buf_5ks(
	clk, rst,
	in_data, in_weight_1,in_weight_2, in_weight_3,in_bias,
	
	out_data_0, out_data_1, out_data_2, out_data_3, out_data_4,
	out_data_5, out_data_6, out_data_7, out_data_8, out_data_9,
	out_data_10, out_data_11, out_data_12, out_data_13, out_data_14,
	out_data_15, out_data_16, out_data_17, out_data_18, out_data_19,
	out_data_20, out_data_21, out_data_22, out_data_23, out_data_24,
	
    out_weight_0, out_weight_1,out_weight_2,out_weight_3,out_weight_4,out_weight_5,out_weight_6,
    out_weight_7,out_weight_8,out_weight_9,out_weight_10,out_weight_11,out_weight_12,out_weight_13,
    out_weight_14,out_weight_15,out_weight_16,out_weight_17,out_weight_18,out_weight_19,out_weight_20,
    out_weight_21,out_weight_22,out_weight_23,out_weight_24,out_weight_25,out_weight_26,out_weight_27,
    out_weight_28,out_weight_29,out_weight_30,out_weight_31,out_weight_32,out_weight_33,out_weight_34,
    out_weight_35,out_weight_36,out_weight_37,out_weight_38,out_weight_39,out_weight_40,out_weight_41,
    out_weight_42,out_weight_43,out_weight_44,out_weight_45,out_weight_46,out_weight_47,out_weight_48,
    out_weight_49,out_weight_50,out_weight_51,out_weight_52,out_weight_53,out_weight_54,out_weight_55,
    out_weight_56,out_weight_57,out_weight_58,out_weight_59,out_weight_60,out_weight_61,out_weight_62,
    out_weight_63,out_weight_64,out_weight_65,out_weight_66,out_weight_67,out_weight_68,out_weight_69,
    out_weight_70,out_weight_71,out_weight_72,out_weight_73,out_weight_74,
    
    bias_0, bias_1, bias_2,
	
	valid_out_1
);

conv_calc_5ks conv_calc_5ks(
	valid_out_1,
	
	out_data_0, out_data_1, out_data_2, out_data_3, out_data_4,
	out_data_5, out_data_6, out_data_7, out_data_8, out_data_9,
	out_data_10, out_data_11, out_data_12, out_data_13, out_data_14,
	out_data_15, out_data_16, out_data_17, out_data_18, out_data_19,
	out_data_20, out_data_21, out_data_22, out_data_23, out_data_24,
	
    out_weight_0, out_weight_1,out_weight_2,out_weight_3,out_weight_4,out_weight_5,out_weight_6,
    out_weight_7,out_weight_8,out_weight_9,out_weight_10,out_weight_11,out_weight_12,out_weight_13,
    out_weight_14,out_weight_15,out_weight_16,out_weight_17,out_weight_18,out_weight_19,out_weight_20,
    out_weight_21,out_weight_22,out_weight_23,out_weight_24,out_weight_25,out_weight_26,out_weight_27,
    out_weight_28,out_weight_29,out_weight_30,out_weight_31,out_weight_32,out_weight_33,out_weight_34,
    out_weight_35,out_weight_36,out_weight_37,out_weight_38,out_weight_39,out_weight_40,out_weight_41,
    out_weight_42,out_weight_43,out_weight_44,out_weight_45,out_weight_46,out_weight_47,out_weight_48,
    out_weight_49,out_weight_50,out_weight_51,out_weight_52,out_weight_53,out_weight_54,out_weight_55,
    out_weight_56,out_weight_57,out_weight_58,out_weight_59,out_weight_60,out_weight_61,out_weight_62,
    out_weight_63,out_weight_64,out_weight_65,out_weight_66,out_weight_67,out_weight_68,out_weight_69,
    out_weight_70,out_weight_71,out_weight_72,out_weight_73,out_weight_74,
    
    bias_0, bias_1, bias_2,

	conv_out_1, conv_out_2, conv_out_3,
	valid_out_2
);

endmodule
