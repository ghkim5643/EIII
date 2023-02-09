module conv_buf_5ks #( parameter WIDTH = 28, HEIGHT = 28, DATA_BIT = 8 )
(
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
	
	valid_out
);

localparam KERNEL_SIZE = 5;

input clk, rst;
input [DATA_BIT - 1 : 0]in_data;
input [3:0] in_weight_1,in_weight_2,in_weight_3;
input [7:0] in_bias;

output reg [DATA_BIT - 1:0] out_data_0, out_data_1, out_data_2, out_data_3, out_data_4,
							out_data_5, out_data_6, out_data_7, out_data_8, out_data_9,
							out_data_10, out_data_11, out_data_12, out_data_13, out_data_14,
							out_data_15, out_data_16, out_data_17, out_data_18, out_data_19,
							out_data_20, out_data_21, out_data_22, out_data_23, out_data_24;
							
output wire [3:0] out_weight_0, out_weight_1,out_weight_2,out_weight_3,out_weight_4,out_weight_5,out_weight_6,
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
           
output wire [7:0] bias_0, bias_1, bias_2;							
				
output reg valid_out;

reg [DATA_BIT - 1:0] buffer [0 : WIDTH * KERNEL_SIZE - 1];
reg [3:0] r_weight [0:74];
reg [7:0] r_bias [0:2];

reg [DATA_BIT - 1:0] buf_count; // Index of Buffer (28 * 5)
reg [4:0] w_count; // Index of width (28)
reg [4:0] h_count; // Index of height (28)
reg [2:0] buf_flag; // Flag of data processing 0 ~ 4
reg state; // 0 : initialize, 1: Output Selection

reg [4:0] reg_count; // Index of weight reg (25)
reg [2:0] bias_count; // Index of bias reg (3)

always @(posedge clk) begin    
	if(rst) begin
		buf_count <= -1;
		reg_count <= -1;
		bias_count <= -1;
		w_count <= -1;
		h_count <= 0;
		buf_flag <= 0;
		state <= 0;
		valid_out <= 0;
	end
	else begin
		buf_count <= buf_count + 1;
		if(buf_count == WIDTH * KERNEL_SIZE - 1) begin
			buf_count <= 0;
		end	
		buffer[buf_count] <= in_data;
		
	    if(reg_count < 24) begin
		  	reg_count <= reg_count + 1;
		  	r_weight[reg_count] <= in_weight_1;
		  	r_weight[reg_count + 25] <= in_weight_2;
		  	r_weight[reg_count + 50] <= in_weight_3;
		end
		
		if (bias_count < 3) begin
		      bias_count <= bias_count + 1;
		      r_bias[bias_count] <= in_bias;
		end
		
		// Initialization
		if(!state) begin
			if(buf_count == WIDTH * KERNEL_SIZE - 1) begin
				state <= 1;
			end
		end
		
		// Output Selection
		else begin // state == 0
			w_count <= w_count + 1;
			
			// Useless Value
			if(w_count == WIDTH - 4) begin
				valid_out <= 0;
			end

			else if(w_count == WIDTH - 1) begin
				buf_flag <= buf_flag + 1;
				if(buf_flag == KERNEL_SIZE - 1) begin
					buf_flag <= 0;
				end
				
				w_count <= 0;
				if(h_count == HEIGHT - 5) begin
					h_count <= 0;
					state <= 0;
				end
				h_count <= h_count + 1;
				
			end
			
			else if(w_count == 0) begin
				valid_out <= 1;
			end
			
			// Buffer Output Selection
			if(buf_flag == 3'd0) begin 
				out_data_0 <= buffer[w_count];
				out_data_1 <= buffer[w_count + 1]; 
				out_data_2 <= buffer[w_count + 2]; 
				out_data_3 <= buffer[w_count + 3]; 
				out_data_4 <= buffer[w_count + 4];
				
				out_data_5 <= buffer[w_count + WIDTH]; 
				out_data_6 <= buffer[w_count + 1 + WIDTH]; 
				out_data_7 <= buffer[w_count + 2 + WIDTH]; 
				out_data_8 <= buffer[w_count + 3 + WIDTH]; 
				out_data_9 <= buffer[w_count + 4 + WIDTH];
				
				out_data_10 <= buffer[w_count + (WIDTH * 2)]; 
				out_data_11 <= buffer[w_count + 1 + (WIDTH * 2)]; 
				out_data_12 <= buffer[w_count + 2 + (WIDTH * 2)]; 
				out_data_13 <= buffer[w_count + 3 + (WIDTH * 2)]; 
				out_data_14 <= buffer[w_count + 4 + (WIDTH * 2)];
				
				out_data_15 <= buffer[w_count + (WIDTH * 3)]; 
				out_data_16 <= buffer[w_count + 1 + (WIDTH * 3)]; 
				out_data_17 <= buffer[w_count + 2 + (WIDTH * 3)]; 
				out_data_18 <= buffer[w_count + 3 + (WIDTH * 3)]; 
				out_data_19 <= buffer[w_count + 4 + (WIDTH * 3)];
				
				out_data_20 <= buffer[w_count + (WIDTH * 4)]; 
				out_data_21 <= buffer[w_count + 1 + (WIDTH * 4)]; 
				out_data_22 <= buffer[w_count + 2 + (WIDTH * 4)]; 
				out_data_23 <= buffer[w_count + 3 + (WIDTH * 4)]; 
				out_data_24 <= buffer[w_count + 4 + (WIDTH * 4)];
			end
			else if(buf_flag == 3'd1) begin 
				out_data_20 <= buffer[w_count]; 
				out_data_21 <= buffer[w_count + 1]; 
				out_data_22 <= buffer[w_count + 2]; 
				out_data_23 <= buffer[w_count + 3]; 
				out_data_24 <= buffer[w_count + 4];
				
				out_data_0 <= buffer[w_count + WIDTH]; 
				out_data_1 <= buffer[w_count + 1 + WIDTH]; 
				out_data_2 <= buffer[w_count + 2 + WIDTH]; 
				out_data_3 <= buffer[w_count + 3 + WIDTH]; 
				out_data_4 <= buffer[w_count + 4 + WIDTH];
				
				out_data_5 <= buffer[w_count + (WIDTH * 2)]; 
				out_data_6 <= buffer[w_count + 1 + (WIDTH * 2)]; 
				out_data_7 <= buffer[w_count + 2 + (WIDTH * 2)]; 
				out_data_8 <= buffer[w_count + 3 + (WIDTH * 2)]; 
				out_data_9 <= buffer[w_count + 4 + (WIDTH * 2)];
				
				out_data_10 <= buffer[w_count + (WIDTH * 3)]; 
				out_data_11 <= buffer[w_count + 1 + (WIDTH * 3)]; 
				out_data_12 <= buffer[w_count + 2 + (WIDTH * 3)]; 
				out_data_13 <= buffer[w_count + 3 + (WIDTH * 3)]; 
				out_data_14 <= buffer[w_count + 4 + (WIDTH * 3)];
				
				out_data_15 <= buffer[w_count + (WIDTH * 4)]; 
				out_data_16 <= buffer[w_count + 1 + (WIDTH * 4)]; 
				out_data_17 <= buffer[w_count + 2 + (WIDTH * 4)]; 
				out_data_18 <= buffer[w_count + 3 + (WIDTH * 4)]; 
				out_data_19 <= buffer[w_count + 4 + (WIDTH * 4)];
			end	
			else if(buf_flag == 3'd2) begin
				out_data_15 <= buffer[w_count]; 
				out_data_16 <= buffer[w_count + 1]; 
				out_data_17 <= buffer[w_count + 2]; 
				out_data_18 <= buffer[w_count + 3]; 
				out_data_19 <= buffer[w_count + 4];
				
				out_data_20 <= buffer[w_count + WIDTH]; 
				out_data_21 <= buffer[w_count + 1 + WIDTH]; 
				out_data_22 <= buffer[w_count + 2 + WIDTH]; 
				out_data_23 <= buffer[w_count + 3 + WIDTH]; 
				out_data_24 <= buffer[w_count + 4 + WIDTH];
				
				out_data_0 <= buffer[w_count + (WIDTH * 2)]; 
				out_data_1 <= buffer[w_count + 1 + (WIDTH * 2)]; 
				out_data_2 <= buffer[w_count + 2 + (WIDTH * 2)]; 
				out_data_3 <= buffer[w_count + 3 + (WIDTH * 2)]; 
				out_data_4 <= buffer[w_count + 4 + (WIDTH * 2)];
				
				out_data_5 <= buffer[w_count + (WIDTH * 3)]; 
				out_data_6 <= buffer[w_count + 1 + (WIDTH * 3)]; 
				out_data_7 <= buffer[w_count + 2 + (WIDTH * 3)]; 
				out_data_8 <= buffer[w_count + 3 + (WIDTH * 3)]; 
				out_data_9 <= buffer[w_count + 4 + (WIDTH * 3)];
				
				out_data_10 <= buffer[w_count + (WIDTH * 4)]; 
				out_data_11 <= buffer[w_count + 1 + (WIDTH * 4)]; 
				out_data_12 <= buffer[w_count + 2 + (WIDTH * 4)]; 
				out_data_13 <= buffer[w_count + 3 + (WIDTH * 4)]; 
				out_data_14 <= buffer[w_count + 4 + (WIDTH * 4)];
			end
			else if(buf_flag == 3'd3) begin
				out_data_10 <= buffer[w_count]; 
				out_data_11 <= buffer[w_count + 1]; 
				out_data_12 <= buffer[w_count + 2]; 
				out_data_13 <= buffer[w_count + 3]; 
				out_data_14 <= buffer[w_count + 4];
				
				out_data_15 <= buffer[w_count + WIDTH]; 
				out_data_16 <= buffer[w_count + 1 + WIDTH]; 
				out_data_17 <= buffer[w_count + 2 + WIDTH]; 
				out_data_18 <= buffer[w_count + 3 + WIDTH]; 
				out_data_19 <= buffer[w_count + 4 + WIDTH];
				
				out_data_20 <= buffer[w_count + (WIDTH * 2)]; 
				out_data_21 <= buffer[w_count + 1 + (WIDTH * 2)]; 
				out_data_22 <= buffer[w_count + 2 + (WIDTH * 2)]; 
				out_data_23 <= buffer[w_count + 3 + (WIDTH * 2)]; 
				out_data_24 <= buffer[w_count + 4 + (WIDTH * 2)];
				
				out_data_0 <= buffer[w_count + (WIDTH * 3)]; 
				out_data_1 <= buffer[w_count + 1 + (WIDTH * 3)]; 
				out_data_2 <= buffer[w_count + 2 + (WIDTH * 3)]; 
				out_data_3 <= buffer[w_count + 3 + (WIDTH * 3)]; 
				out_data_4 <= buffer[w_count + 4 + (WIDTH * 3)];
				
				out_data_5 <= buffer[w_count + (WIDTH * 4)]; 
				out_data_6 <= buffer[w_count + 1 + (WIDTH * 4)]; 
				out_data_7 <= buffer[w_count + 2 + (WIDTH * 4)]; 
				out_data_8 <= buffer[w_count + 3 + (WIDTH * 4)]; 
				out_data_9 <= buffer[w_count + 4 + (WIDTH * 4)];
			end
			else if(buf_flag == 3'd4) begin
				out_data_5 <= buffer[w_count]; 
				out_data_6 <= buffer[w_count + 1]; 
				out_data_7 <= buffer[w_count + 2]; 
				out_data_8 <= buffer[w_count + 3]; 
				out_data_9 <= buffer[w_count + 4];
				
				out_data_10 <= buffer[w_count + WIDTH]; 
				out_data_11 <= buffer[w_count + 1 + WIDTH]; 
				out_data_12 <= buffer[w_count + 2 + WIDTH]; 
				out_data_13 <= buffer[w_count + 3 + WIDTH]; 
				out_data_14 <= buffer[w_count + 4 + WIDTH];
				
				out_data_15 <= buffer[w_count + (WIDTH * 2)]; 
				out_data_16 <= buffer[w_count + 1 + (WIDTH * 2)]; 
				out_data_17 <= buffer[w_count + 2 + (WIDTH * 2)]; 
				out_data_18 <= buffer[w_count + 3 + (WIDTH * 2)]; 
				out_data_19 <= buffer[w_count + 4 + (WIDTH * 2)];
				
				out_data_20 <= buffer[w_count + (WIDTH * 3)]; 
				out_data_21 <= buffer[w_count + 1 + (WIDTH * 3)]; 
				out_data_22 <= buffer[w_count + 2 + (WIDTH * 3)]; 
				out_data_23 <= buffer[w_count + 3 + (WIDTH * 3)]; 
				out_data_24 <= buffer[w_count + 4 + (WIDTH * 3)];
				
				out_data_0 <= buffer[w_count + (WIDTH * 4)]; 
				out_data_1 <= buffer[w_count + 1 + (WIDTH * 4)]; 
				out_data_2 <= buffer[w_count + 2 + (WIDTH * 4)]; 
				out_data_3 <= buffer[w_count + 3 + (WIDTH * 4)]; 
				out_data_4 <= buffer[w_count + 4 + (WIDTH * 4)];
			end
			
		end
	end
end

assign out_weight_0 = r_weight[0];
assign out_weight_1 = r_weight[1];
assign out_weight_2 = r_weight[2];
assign out_weight_3 = r_weight[3];
assign out_weight_4 = r_weight[4];
assign out_weight_5 = r_weight[5];
assign out_weight_6 = r_weight[6];
assign out_weight_7 = r_weight[7];
assign out_weight_8 = r_weight[8];
assign out_weight_9 = r_weight[9];
assign out_weight_10 = r_weight[10];
assign out_weight_11 = r_weight[11];
assign out_weight_12 = r_weight[12];
assign out_weight_13 = r_weight[13];
assign out_weight_14 = r_weight[14];
assign out_weight_15 = r_weight[15];
assign out_weight_16 = r_weight[16];
assign out_weight_17 = r_weight[17];
assign out_weight_18 = r_weight[18];
assign out_weight_19 = r_weight[19];
assign out_weight_20 = r_weight[20];
assign out_weight_21 = r_weight[21];
assign out_weight_22 = r_weight[22];
assign out_weight_23 = r_weight[23];
assign out_weight_24 = r_weight[24];
assign out_weight_25 = r_weight[25];
assign out_weight_26 = r_weight[26];
assign out_weight_27 = r_weight[27];
assign out_weight_28 = r_weight[28];
assign out_weight_29 = r_weight[29];
assign out_weight_30 = r_weight[30];
assign out_weight_31 = r_weight[31];
assign out_weight_32 = r_weight[32];
assign out_weight_33 = r_weight[33];
assign out_weight_34 = r_weight[34];
assign out_weight_35 = r_weight[35];
assign out_weight_36 = r_weight[36];
assign out_weight_37 = r_weight[37];
assign out_weight_38 = r_weight[38];
assign out_weight_39 = r_weight[39];
assign out_weight_40 = r_weight[40];
assign out_weight_41 = r_weight[41];
assign out_weight_42 = r_weight[42];
assign out_weight_43 = r_weight[43];
assign out_weight_44 = r_weight[44];
assign out_weight_45 = r_weight[45];
assign out_weight_46 = r_weight[46];
assign out_weight_47 = r_weight[47];
assign out_weight_48 = r_weight[48];
assign out_weight_49 = r_weight[49];
assign out_weight_50 = r_weight[50];
assign out_weight_51 = r_weight[51];
assign out_weight_52 = r_weight[52];
assign out_weight_53 = r_weight[53];
assign out_weight_54 = r_weight[54];
assign out_weight_55 = r_weight[55];
assign out_weight_56 = r_weight[56];
assign out_weight_57 = r_weight[57];
assign out_weight_58 = r_weight[58];
assign out_weight_59 = r_weight[59];
assign out_weight_60 = r_weight[60];
assign out_weight_61 = r_weight[61];
assign out_weight_62 = r_weight[62];
assign out_weight_63 = r_weight[63];
assign out_weight_64 = r_weight[64];
assign out_weight_65 = r_weight[65];
assign out_weight_66 = r_weight[66];
assign out_weight_67 = r_weight[67];
assign out_weight_68 = r_weight[68];
assign out_weight_69 = r_weight[69];
assign out_weight_70 = r_weight[70];
assign out_weight_71 = r_weight[71];
assign out_weight_72 = r_weight[72];
assign out_weight_73 = r_weight[73];
assign out_weight_74 = r_weight[74];

assign bias_0 = r_bias[0];
assign bias_1 = r_bias[1];
assign bias_2 = r_bias[2];

endmodule