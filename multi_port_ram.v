`timescale 1ns/1ps

module single_port_ram
 #(parameter ADDR_WIDTH = 16,
   parameter DATA_WIDTH = 32//고정
 )
   
(	
	input				    clk,
	input  [DATA_WIDTH-1:0] i_data1, i_data2, i_data3, i_data4, i_data5, i_data6, i_data7, i_data8, i_data9, i_data10, i_data11, i_data12, i_data13, i_data14, i_data15, i_data16,
	input  [ADDR_WIDTH-1:0] addr1, addr2, addr3, addr4, addr5, addr6, addr7, addr8, addr9, addr10, addr11, addr12, addr13, addr14, addr15, addr16,
	input				    we1, we2, we3, we4, we5, we6, we7, we8, we9, we10, we11, we12, we13, we14, we15, we16,
	
	output [DATA_WIDTH-1:0] o_data1, o_data2, o_data3, o_data4, o_data5, o_data6, o_data7, o_data8, o_data9, o_data10, o_data11, o_data12, o_data13, o_data14, o_data15, o_data16
);



reg [DATA_WIDTH-1:0] r_mem [ADDR_WIDTH-1:0];
reg [ADDR_WIDTH-1:0] r_addr1, r_addr2, r_addr3, r_addr4, r_addr5, r_addr6, r_addr7, r_addr8, r_addr9, r_addr10, r_addr11, r_addr12, r_addr13, r_addr14, r_addr15, r_addr16;


always @(posedge clk) begin
    if(we1)
         r_mem[addr1] <= i_data1;
	else
	     r_addr1 <= addr1;
end

always @(posedge clk) begin
    if(we2)
         r_mem[addr2] <= i_data2;
	else
	     r_addr2 <= addr2;
end

always @(posedge clk) begin
    if(we3)
         r_mem[addr3] <= i_data3;
	else
	     r_addr3 <= addr3;
end

always @(posedge clk) begin
    if(we4)
         r_mem[addr4] <= i_data4;
	else
	     r_addr4 <= addr4;
end

always @(posedge clk) begin
    if(we5)
         r_mem[addr5] <= i_data5;
	else
	     r_addr5 <= addr5;
end

always @(posedge clk) begin
    if(we6)
         r_mem[addr6] <= i_data6;
	else
	     r_addr6 <= addr6;
end

always @(posedge clk) begin
    if(we7)
         r_mem[addr7] <= i_data7;
	else
	     r_addr7 <= addr7;
end

always @(posedge clk) begin
    if(we8)
         r_mem[addr8] <= i_data8;
	else
	     r_addr8 <= addr8;
end

always @(posedge clk) begin
    if(we9)
         r_mem[addr9] <= i_data9;
	else
	     r_addr9 <= addr9;
end

always @(posedge clk) begin
    if(we10)
         r_mem[addr10] <= i_data10;
	else
	     r_addr10 <= addr10;
end

always @(posedge clk) begin
    if(we11)
         r_mem[addr11] <= i_data11;
	else
	     r_addr11 <= addr11;
end

always @(posedge clk) begin
    if(we12)
         r_mem[addr12] <= i_data12;
	else
	     r_addr12 <= addr12;
end

always @(posedge clk) begin
    if(we13)
         r_mem[addr13] <= i_data13;
	else
	     r_addr13 <= addr13;
end

always @(posedge clk) begin
    if(we14)
         r_mem[addr14] <= i_data14;
	else
	     r_addr14 <= addr14;
end

always @(posedge clk) begin
    if(we15)
         r_mem[addr15] <= i_data15;
	else
	     r_addr15 <= addr15;
end

always @(posedge clk) begin
    if(we16)
         r_mem[addr16] <= i_data16;
	else
	     r_addr16 <= addr16;
end

assign o_data1 = r_mem[r_addr1];
assign o_data2 = r_mem[r_addr2];
assign o_data3 = r_mem[r_addr3];
assign o_data4 = r_mem[r_addr4];
assign o_data5 = r_mem[r_addr5];
assign o_data6 = r_mem[r_addr6];
assign o_data7 = r_mem[r_addr7];
assign o_data8 = r_mem[r_addr8];
assign o_data9 = r_mem[r_addr9];
assign o_data10 = r_mem[r_addr10];
assign o_data11 = r_mem[r_addr11];
assign o_data12 = r_mem[r_addr12];
assign o_data13 = r_mem[r_addr13];
assign o_data14 = r_mem[r_addr14];
assign o_data15 = r_mem[r_addr15];
assign o_data16 = r_mem[r_addr16];



endmodule