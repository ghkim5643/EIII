`timescale 1ns / 1ps
module tb_quantizer;

reg         clk;
reg         reset_n;
reg  [31:0] r_max;
reg  [31:0] r_activation;
wire [7:0]  w_index;

//integer i;

quantizer u_quantizer(
    .clk(clk), .reset_n(reset_n),
    .i_max(r_max), .i_activation(r_activation),
    .o_index(w_index)
);

// clk gen
always
    #5 clk = ~clk;

initial begin
//initialize value
$display("initialize value [%d]", $time);
    reset_n      = 1;
    clk          = 0;



// reset_n gen
$display("Reset! [%d]", $time);
# 10
    reset_n      = 0;
    r_max        = 32'h 43800000; // 256   -> unit  = 1.0
    r_activation = 32'h 42040000; // 33    -> index = 33
# 100
    reset_n = 1;
# 10
    r_activation = 32'h 3E800000; // 0.5     -> index = 0
# 10 
    r_activation = 32'h 3F800000; // 1       -> index = 1
# 10 
    r_activation = 32'h 40000000; // 2       -> index = 2
# 10 
    r_activation = 32'h 40400000; // 3       -> index = 3
# 10
    r_activation = 32'h 41000000; // 8       -> index = 8
# 10
    r_activation = 32'h 437F0000; // 255     -> index = 255
# 10
    r_activation = 32'h 43800000; // 256     -> index = 255
# 10
    r_activation = 32'h 43808000; // 257     -> index = 255
# 10
    r_activation = 32'h 448D5800; // 1130.75 -> index = 255

# 10
    r_max        = 32'h 440C4000; // 561     -> unit  = 2.191
    r_activation = 32'h 3E800000; // 0.5     -> index = 0
# 10 
    r_activation = 32'h 3F800000; // 1       -> index = 0
# 10 
    r_activation = 32'h 40000000; // 2       -> index = 0
# 10 
    r_activation = 32'h 40400000; // 3       -> index = 1
# 10
    r_activation = 32'h 41000000; // 8       -> index = 3
# 10
    r_activation = 32'h 437F0000; // 255     -> index = 116
# 10
    r_activation = 32'h 43800000; // 256     -> index = 116
# 10
    r_activation = 32'h 43808000; // 257     -> index = 117
# 10
    r_activation = 32'h 448D5800; // 1130.75 -> index = 255
# 10
    r_activation = 32'h 00000000; // 0       -> index = 0

# 120
$display("Finish! [%d]", $time);
//$fclose(fd);
$finish;

end

endmodule