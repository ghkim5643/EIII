`timescale 1ns/1ps


module tb_single_port_ram;
parameter ADDR_WIDTH = 16;
parameter DATA_WIDTH = 32;

reg [ADDR_WIDTH-1:0] addr1, addr2, addr3, addr4, addr5, addr6, addr7, addr8, addr9, addr10, addr11, addr12, addr13, addr14, addr15, addr16;
reg [DATA_WIDTH-1:0] i_data1, i_data2, i_data3, i_data4, i_data5, i_data6, i_data7, i_data8, i_data9, i_data10, i_data11, i_data12, i_data13, i_data14, i_data15, i_data16;
reg we1, we2, we3, we4, we5, we6, we7, we8, we9, we10, we11, we12, we13, we14, we15, we16;
reg clk;
wire [DATA_WIDTH-1:0] o_data1, o_data2, o_data3, o_data4, o_data5, o_data6, o_data7, o_data8, o_data9, o_data10, o_data11, o_data12, o_data13, o_data14, o_data15, o_data16;

single_port_ram #(.DATA_WIDTH(DATA_WIDTH)) u0
(   .clk(clk),
    .addr1(addr1),
    .addr2(addr2),
    .addr3(addr3),
	.addr4(addr4),
	.addr5(addr5),
	.addr6(addr6),
	.addr7(addr7),
	.addr8(addr8),
	.addr9(addr9),
	.addr10(addr10),
	.addr11(addr11),
	.addr12(addr12),
	.addr13(addr13),
	.addr14(addr14),
	.addr15(addr15),
	.addr16(addr16),
    .we1(we1),
	.we2(we2),
	.we3(we3),
	.we4(we4),
	.we5(we5),
	.we6(we6),
	.we7(we7),
	.we8(we8),
	.we9(we9),
	.we10(we10),
	.we11(we11),
	.we12(we12),
	.we13(we13),
	.we14(we14),
	.we15(we15),
	.we16(we16),
	.o_data1(o_data1),
	.o_data2(o_data2),
	.o_data3(o_data3),
	.o_data4(o_data4),
	.o_data5(o_data5),
	.o_data6(o_data6),
	.o_data7(o_data7),
	.o_data8(o_data8),
	.o_data9(o_data9),
	.o_data10(o_data10),
	.o_data11(o_data11),
	.o_data12(o_data12),
	.o_data13(o_data13),
	.o_data14(o_data14),
	.o_data15(o_data15),
	.o_data16(o_data16),
	.i_data1(i_data1),
	.i_data2(i_data2),
	.i_data3(i_data3),
	.i_data4(i_data4),
	.i_data5(i_data5),
	.i_data6(i_data6),
	.i_data7(i_data7),
	.i_data8(i_data8),
	.i_data9(i_data9),
	.i_data10(i_data10),
	.i_data11(i_data11),
	.i_data12(i_data12),
	.i_data13(i_data13),
	.i_data14(i_data14),
	.i_data15(i_data15),
	.i_data16(i_data16)
);

initial begin
    clk = 1'b1;
	forever #10 clk=~clk;
end

initial begin
	we1 = 1'b1;
	we2 = 1'b1;
	we11 = 1'b1;
	#20;

	addr1 = 5'd0;
	i_data1 = 8'h10;
	#20;

	addr2 = 5'd2;
	i_data2 = 8'h11;
	#20;
	
	addr11 = 5'd7;
	i_data11 = 8'haf;
	#20;

	we1 = 1'b0;
	we2 = 1'b0;
	we11 = 1'b0;

	addr1 = 5'd0;
	#20;

	addr2 = 5'd2;
	#20;

	addr11 = 5'd7;
	#20;

	$finish;

end

endmodule