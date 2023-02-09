module converter(
    clk, rst, in_bias,

    out_bias
);

input clk,rst;
input [31:0] in_bias;
output [7:0] out_bias;
reg [6:0] r_bias;

always @(posedge clk or posedge rst) begin
    if (rst) 
        r_bias = 0;
    else begin
        if (in_bias[30:23] < 8'd127)
            r_bias = 7'b0000000;
        else begin
            case(in_bias[30:23])
                127 : r_bias = {6'b000000 , in_bias[22]};
                128 : r_bias = {5'b00000 , in_bias[22:21]};
                129 : r_bias = {4'b0000 , in_bias[22:20]};
                130 : r_bias = {3'b000 , in_bias[22:19]};
                131 : r_bias = {2'b00 , in_bias[22:18]}; 
                132 : r_bias = {1'b0 , in_bias[22:17]};
                133 : r_bias = in_bias[22:16];
                default : r_bias = 7'b11111111;
            endcase
        end
   end
end

assign out_bias = {in_bias[31] , r_bias};

endmodule