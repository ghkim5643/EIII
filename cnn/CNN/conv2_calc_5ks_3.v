module conv2_calc_5ks_3(
	valid_in, clk, rst,
	
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
	valid_out
);

input valid_in, clk, rst;

input [11:0] out_data_0, out_data_1, out_data_2, out_data_3, out_data_4,
			out_data_5, out_data_6, out_data_7, out_data_8, out_data_9,
			out_data_10, out_data_11, out_data_12, out_data_13, out_data_14,
			out_data_15, out_data_16, out_data_17, out_data_18, out_data_19,
			out_data_20, out_data_21, out_data_22, out_data_23, out_data_24;
			
input [3:0] out_weight_0, out_weight_1,out_weight_2,out_weight_3,out_weight_4,out_weight_5,out_weight_6,
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
            
input [7:0] bias_0, bias_1, bias_2;			

// calc_out / 256 = conv_out
output signed [11:0] conv_out_1;
output signed [11:0] conv_out_2;
output signed [11:0] conv_out_3;

output valid_out;

wire signed [19:0] calc_out_1; // 2^18
wire signed [19:0] calc_out_2; // 2^18
wire signed [19:0] calc_out_3; // 2^18

wire signed [11:0] exp_bias [0:2];

reg [3:0] weight_1 [0:24];
reg [3:0] weight_2 [0:24];
reg [3:0] weight_3 [0:24];

wire signed [18:0] mul_out_1 [0:24]; //change
wire signed [18:0] mul_out_2 [0:24]; //change
wire signed [18:0] mul_out_3 [0:24]; //change

wire [11:0] exp_data [0:24];

assign exp_data[0] = out_data_0;
assign exp_data[1] = out_data_1;
assign exp_data[2] = out_data_2;
assign exp_data[3] = out_data_3;
assign exp_data[4] = out_data_4;
assign exp_data[5] = out_data_5;
assign exp_data[6] = out_data_6;
assign exp_data[7] = out_data_7;
assign exp_data[8] = out_data_8;
assign exp_data[9] = out_data_9;
assign exp_data[10] = out_data_10;
assign exp_data[11] = out_data_11;
assign exp_data[12] = out_data_12;
assign exp_data[13] = out_data_13;
assign exp_data[14] = out_data_14;
assign exp_data[15] = out_data_15;
assign exp_data[16] = out_data_16;
assign exp_data[17] = out_data_17;
assign exp_data[18] = out_data_18;
assign exp_data[19] = out_data_19;
assign exp_data[20] = out_data_20;
assign exp_data[21] = out_data_21;
assign exp_data[22] = out_data_22;
assign exp_data[23] = out_data_23;
assign exp_data[24] = out_data_24;

assign exp_bias[0] = (bias_0[7] == 1) ? {4'b1111, bias_0} : {4'd0, bias_0};
assign exp_bias[1] = (bias_1[7] == 1) ? {4'b1111, bias_1} : {4'd0, bias_1};
assign exp_bias[2] = (bias_2[7] == 1) ? {4'b1111, bias_2} : {4'd0, bias_2};

pe_2 pe3_1_0(clk, rst, out_weight_0, exp_data[0],  mul_out_1[0]);
pe_2 pe3_1_1(clk, rst, out_weight_1, exp_data[1],  mul_out_1[1]);
pe_2 pe3_1_2(clk, rst, out_weight_2, exp_data[2],  mul_out_1[2]);
pe_2 pe3_1_3(clk, rst, out_weight_3, exp_data[3],  mul_out_1[3]);
pe_2 pe3_1_4(clk, rst, out_weight_4, exp_data[4],  mul_out_1[4]);
pe_2 pe3_1_5(clk, rst, out_weight_5, exp_data[5],  mul_out_1[5]);
pe_2 pe3_1_6(clk, rst, out_weight_6, exp_data[6],  mul_out_1[6]);
pe_2 pe3_1_7(clk, rst, out_weight_7, exp_data[7],  mul_out_1[7]);
pe_2 pe3_1_8(clk, rst, out_weight_8, exp_data[8],  mul_out_1[8]);
pe_2 pe3_1_9(clk, rst, out_weight_9, exp_data[9],  mul_out_1[9]);
pe_2 pe3_1_10(clk, rst, out_weight_10, exp_data[10],  mul_out_1[10]);
pe_2 pe3_1_11(clk, rst, out_weight_11, exp_data[11],  mul_out_1[11]);
pe_2 pe3_1_12(clk, rst, out_weight_12, exp_data[12],  mul_out_1[12]);
pe_2 pe3_1_13(clk, rst, out_weight_13, exp_data[13],  mul_out_1[13]);
pe_2 pe3_1_14(clk, rst, out_weight_14, exp_data[14],  mul_out_1[14]);
pe_2 pe3_1_15(clk, rst, out_weight_15, exp_data[15],  mul_out_1[15]);
pe_2 pe3_1_16(clk, rst, out_weight_16, exp_data[16],  mul_out_1[16]);
pe_2 pe3_1_17(clk, rst, out_weight_17, exp_data[17],  mul_out_1[17]);
pe_2 pe3_1_18(clk, rst, out_weight_18, exp_data[18],  mul_out_1[18]);
pe_2 pe3_1_19(clk, rst, out_weight_19, exp_data[19],  mul_out_1[19]);
pe_2 pe3_1_20(clk, rst, out_weight_20, exp_data[20],  mul_out_1[20]);
pe_2 pe3_1_21(clk, rst, out_weight_21, exp_data[21],  mul_out_1[21]);
pe_2 pe3_1_22(clk, rst, out_weight_22, exp_data[22],  mul_out_1[22]);
pe_2 pe3_1_23(clk, rst, out_weight_23, exp_data[23],  mul_out_1[23]);
pe_2 pe3_1_24(clk, rst, out_weight_24, exp_data[24],  mul_out_1[24]);

pe_2 pe3_2_0(clk, rst, out_weight_25, exp_data[0],  mul_out_2[0]);
pe_2 pe3_2_1(clk, rst, out_weight_26, exp_data[1],  mul_out_2[1]);
pe_2 pe3_2_2(clk, rst, out_weight_27, exp_data[2],  mul_out_2[2]);
pe_2 pe3_2_3(clk, rst, out_weight_28, exp_data[3],  mul_out_2[3]);
pe_2 pe3_2_4(clk, rst, out_weight_29, exp_data[4],  mul_out_2[4]);
pe_2 pe3_2_5(clk, rst, out_weight_30, exp_data[5],  mul_out_2[5]);
pe_2 pe3_2_6(clk, rst, out_weight_31, exp_data[6],  mul_out_2[6]);
pe_2 pe3_2_7(clk, rst, out_weight_32, exp_data[7],  mul_out_2[7]);
pe_2 pe3_2_8(clk, rst, out_weight_33, exp_data[8],  mul_out_2[8]);
pe_2 pe3_2_9(clk, rst, out_weight_34, exp_data[9],  mul_out_2[9]);
pe_2 pe3_2_10(clk, rst, out_weight_35, exp_data[10],  mul_out_2[10]);
pe_2 pe3_2_11(clk, rst, out_weight_36, exp_data[11],  mul_out_2[11]);
pe_2 pe3_2_12(clk, rst, out_weight_37, exp_data[12],  mul_out_2[12]);
pe_2 pe3_2_13(clk, rst, out_weight_38, exp_data[13],  mul_out_2[13]);
pe_2 pe3_2_14(clk, rst, out_weight_39, exp_data[14],  mul_out_2[14]);
pe_2 pe3_2_15(clk, rst, out_weight_40, exp_data[15],  mul_out_2[15]);
pe_2 pe3_2_16(clk, rst, out_weight_41, exp_data[16],  mul_out_2[16]);
pe_2 pe3_2_17(clk, rst, out_weight_42, exp_data[17],  mul_out_2[17]);
pe_2 pe3_2_18(clk, rst, out_weight_43, exp_data[18],  mul_out_2[18]);
pe_2 pe3_2_19(clk, rst, out_weight_44, exp_data[19],  mul_out_2[19]);
pe_2 pe3_2_20(clk, rst, out_weight_45, exp_data[20],  mul_out_2[20]);
pe_2 pe3_2_21(clk, rst, out_weight_46, exp_data[21],  mul_out_2[21]);
pe_2 pe3_2_22(clk, rst, out_weight_47, exp_data[22],  mul_out_2[22]);
pe_2 pe3_2_23(clk, rst, out_weight_48, exp_data[23],  mul_out_2[23]);
pe_2 pe3_2_24(clk, rst, out_weight_49, exp_data[24],  mul_out_2[24]);

pe_2 pe3_3_0(clk, rst, out_weight_50, exp_data[0],  mul_out_3[0]);
pe_2 pe3_3_1(clk, rst, out_weight_51, exp_data[1],  mul_out_3[1]);
pe_2 pe3_3_2(clk, rst, out_weight_52, exp_data[2],  mul_out_3[2]);
pe_2 pe3_3_3(clk, rst, out_weight_53, exp_data[3],  mul_out_3[3]);
pe_2 pe3_3_4(clk, rst, out_weight_54, exp_data[4],  mul_out_3[4]);
pe_2 pe3_3_5(clk, rst, out_weight_55, exp_data[5],  mul_out_3[5]);
pe_2 pe3_3_6(clk, rst, out_weight_56, exp_data[6],  mul_out_3[6]);
pe_2 pe3_3_7(clk, rst, out_weight_57, exp_data[7],  mul_out_3[7]);
pe_2 pe3_3_8(clk, rst, out_weight_58, exp_data[8],  mul_out_3[8]);
pe_2 pe3_3_9(clk, rst, out_weight_59, exp_data[9],  mul_out_3[9]);
pe_2 pe3_3_10(clk, rst, out_weight_60, exp_data[10],  mul_out_3[10]);
pe_2 pe3_3_11(clk, rst, out_weight_61, exp_data[11],  mul_out_3[11]);
pe_2 pe3_3_12(clk, rst, out_weight_62, exp_data[12],  mul_out_3[12]);
pe_2 pe3_3_13(clk, rst, out_weight_63, exp_data[13],  mul_out_3[13]);
pe_2 pe3_3_14(clk, rst, out_weight_64, exp_data[14],  mul_out_3[14]);
pe_2 pe3_3_15(clk, rst, out_weight_65, exp_data[15],  mul_out_3[15]);
pe_2 pe3_3_16(clk, rst, out_weight_66, exp_data[16],  mul_out_3[16]);
pe_2 pe3_3_17(clk, rst, out_weight_67, exp_data[17],  mul_out_3[17]);
pe_2 pe3_3_18(clk, rst, out_weight_68, exp_data[18],  mul_out_3[18]);
pe_2 pe3_3_19(clk, rst, out_weight_69, exp_data[19],  mul_out_3[19]);
pe_2 pe3_3_20(clk, rst, out_weight_70, exp_data[20],  mul_out_3[20]);
pe_2 pe3_3_21(clk, rst, out_weight_71, exp_data[21],  mul_out_3[21]);
pe_2 pe3_3_22(clk, rst, out_weight_72, exp_data[22],  mul_out_3[22]);
pe_2 pe3_3_23(clk, rst, out_weight_73, exp_data[23],  mul_out_3[23]);
pe_2 pe3_3_24(clk, rst, out_weight_74, exp_data[24],  mul_out_3[24]);

assign calc_out_1 =   mul_out_1[0] + mul_out_1[1] + mul_out_1[2] + mul_out_1[3] + mul_out_1[4] 
                    + mul_out_1[5] + mul_out_1[6] + mul_out_1[7] + mul_out_1[8] + mul_out_1[9]
                    + mul_out_1[10] + mul_out_1[11] + mul_out_1[12] + mul_out_1[13] + mul_out_1[14]
                    + mul_out_1[15] + mul_out_1[16] + mul_out_1[17] + mul_out_1[18] + mul_out_1[19] 
                    + mul_out_1[20] + mul_out_1[21] + mul_out_1[22] + mul_out_1[23] + mul_out_1[24];

assign calc_out_2 =   mul_out_2[0] + mul_out_2[1] + mul_out_2[2] + mul_out_2[3] + mul_out_2[4] 
                    + mul_out_2[5] + mul_out_2[6] + mul_out_2[7] + mul_out_2[8] + mul_out_2[9] 
                    + mul_out_2[10] + mul_out_2[11] + mul_out_2[12] + mul_out_2[13] + mul_out_2[14] 
                    + mul_out_2[15] + mul_out_2[16] + mul_out_2[17] + mul_out_2[18] + mul_out_2[19] 
                    + mul_out_2[20] + mul_out_2[21] + mul_out_2[22] + mul_out_2[23] + mul_out_2[24];
				
assign calc_out_3 =   mul_out_3[0] + mul_out_3[1] + mul_out_3[2] + mul_out_3[3] + mul_out_3[4] 
                    + mul_out_3[5] + mul_out_3[6] + mul_out_3[7] + mul_out_3[8] + mul_out_3[9] 
                    + mul_out_3[10] + mul_out_3[11] + mul_out_3[12] + mul_out_3[13] + mul_out_3[14] 
                    + mul_out_3[15] + mul_out_3[16] + mul_out_3[17] + mul_out_3[18] + mul_out_3[19] 
                    + mul_out_3[20] + mul_out_3[21] + mul_out_3[22] + mul_out_3[23] + mul_out_3[24];	

assign conv_out_1 = calc_out_1[19:8] + exp_bias[0]; // 12 bits
assign conv_out_2 = calc_out_2[19:8] + exp_bias[1];
assign conv_out_3 = calc_out_3[19:8] + exp_bias[2];

assign valid_out = valid_in;

endmodule