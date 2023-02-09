`timescale 1ns / 1ps
module tb_pe;
reg        clk;
reg        reset_n;
reg [3:0]  i_weight;
reg [7:0]  i_activation;
wire [31:0] o_calculated;

integer i;

// clk gen
always
    #5 clk = ~clk;

initial begin
//initialize value
$display("initialize value [%d]", $time);
    reset_n      = 1;
    clk          = 0;
   i_weight     = 0;
   i_activation = 0;
   
// reset_n gen
$display("Reset! [%d]", $time);
# 50
    reset_n = 0;
# 10
    reset_n = 1;
# 10
@(posedge clk);
    for(i=0; i<5; i = i+1) begin
        @(negedge clk);
        i_weight = i_weight+1;
        i_activation = i_activation+1;
    end

#10
    i_weight = 0;

@(posedge clk);
    for(i=6; i<16; i = i+1) begin
        @(negedge clk);
        i_weight = i_weight+1;
        i_activation = i_activation+1;
    end

# 100
$display("Finish! [%d]", $time);
//$fclose(fd);
$finish;
end

pe u_pe(
    .clk (clk),
    .reset_n (reset_n),
    .i_weight (i_weight),
    .i_activation (i_activation),
    .o_calculated (o_calculated)
);
endmodule