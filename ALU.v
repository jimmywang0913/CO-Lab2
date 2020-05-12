// Author:0716029 王吉磊 0716081 葉晨

module ALU(
    src1_i,
    src2_i,
    ctrl_i,
    result_o,
    zero_o
    );

//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
input  [4-1:0]   ctrl_i;

output [32-1:0]	 result_o;
output           zero_o;
wire             zero_o;
assign result_o = (ctrl_i == 4'b0010 )? src1_i+src2_i:
				  (ctrl_i == 4'b0110 )? src1_i-src2_i:
				  (ctrl_i == 4'b0000 )? src1_i&src2_i:
				  (ctrl_i == 4'b0001 )? src1_i|src2_i:
				  (ctrl_i == 4'b0111 )? ((src1_i<src2_i)? 1: 0):
				  0;
assign zero_o = (result_o == 32'b00000000000000000000000000000000)? 1: 0;
endmodule
