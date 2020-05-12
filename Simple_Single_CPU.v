// Author:

module Simple_Single_CPU(
    clk_i,
    rst_i
    );

// Input port
input clk_i;
input rst_i;
wire [31:0] pc_in_i,pc_out_o,sum_o1,shift_left2_o,instr_o,RDdata_i,RTdata_o,SE_o,ZE_o,alu_i1,alu_i2,alur_o,sum_o2,shifter_o;
wire [4:0] RSaddr_i,RTaddr_i,RDaddr_i,Regwrite_i,shiftmux_o;
wire [3:0] ALUCtrl_o;
wire [2:0] ALU_op_o;
wire [1:0] ALUSrc_o,Branch_o;
wire RegDst_o,result_o,leftRight_o,shift_o,b_o,zero_o,RegWrite_o;

ProgramCounter PC(//ok
    .clk_i(clk_i),
    .rst_i (rst_i),
    .pc_in_i(pc_in_i),
    .pc_out_o(pc_out_o)
    );

Adder Adder1(//ok
    .src1_i(pc_out_o),
    .src2_i(4),
    .sum_o(sum_o1)
    );
Adder Adder2(//ok
    .src1_i(sum_o1),
    .src2_i(shift_left2_o),
    .sum_o(sum_o2)
    );
branchornot bon(//ok
    .data0_i(Branch_o[0]),
    .data1_i(Branch_o[1]),
    .data2_i(zero_o),
    .data3_i(Branch_o[0]),
	.data4_i(Branch_o[1]),
	.data5_i(zero_o),
    .data_o(b_o)
    );
MUX_2to1 #(.size(32)) Mux_PC_Source(//ok
    .data0_i(sum_o1),
    .data1_i(sum_o2),
    .select_i(b_o),
    .data_o(pc_in_i)
    );
Instr_Memory IM(//ok
    .pc_addr_i(pc_out_o),
    .instr_o(instr_o)
    );
Reg_File RF(//ok
    .clk_i(clk_i),
    .rst_i(rst_i) ,
    .RSaddr_i(instr_o[25:21]) ,
    .RTaddr_i(instr_o[20:16]) ,
    .RDaddr_i(instr_o[15:11]) ,
    .RDdata_i(RDdata_i)  ,
    .RegWrite_i (Regwrite_o),
    .RSdata_o(alu_i1) ,
    .RTdata_o(RTdata_o)
    );

Decoder Decoder(//ok
    .instr_op_i(instr_o[31:26]),
    .RegWrite_o(RegWrite_o),
    .ALU_op_o(ALU_op_o),
    .ALUSrc_o(ALUSrc_o),
    .RegDst_o(RegDst_o),
    .Branch_o(Branch_o)
    );
ALU_Ctrl AC(//ok
    .funct_i(instr_o[5:0]),
    .ALUOp_i(ALU_op_o),
    .ALUCtrl_o(ALUCtrl_o),
    .result_o(result_o),
    .leftRight_o(leftRight_o),
    .shift_o(shift_o)
    );
MUX_2to1 #(.size(5)) Mux_Write_Reg(//ok
    .data0_i(instr_o[20:16]),
    .data1_i(instr_o[15:11]),
    .select_i(RegDst_o),
    .data_o(Regwrite_i)
    );
Sign_Extend SE(//ok
    .data_i(instr_o[15:0]),
    .data_o(SE_o)
    );
Shift_Left_Two_32 Shifter2(//ok
    .data_i(SE_o),
    .data_o(shift_left2_o)
    );
Zero_Extend ZE(//ok
    .data_i(instr_o[15:0]),
    .data_o(ZE_o)
    );
MUX_4to1 #(.size(32)) MUX_4to11(//ok
    .data0_i(RTdata_o),
    .data1_i(SE_o),
    .data2_i(ZE_o),
    .data3_i(0),
    .select_i(ALUSrc_o),
    .data_o(alu_i2)
    );
ALU ALU(//ok
    .src1_i(alu_i1),
    .src2_i(alu_i2),
    .ctrl_i(ALUCtrl_o),
    .result_o(alur_o),
    .zero_o(zero_o)
    );
MUX_2to1 #(.size(32)) Mux_ALUSrc(//ok
    .data0_i(alur_o),
    .data1_i(shifter_o),
    .select_i(result_o),
    .data_o(RDdata_i)
    );
MUX_2to1 #(.size(5)) shiftmux(//
    .data0_i(instr_o[10:6]),
    .data1_i(alu_i1[4:0]),
    .select_i(shift_o),
    .data_o(shiftmux_o)
    );
shifter sh(//ok
	.leftRight(leftRight_o),
    .data_i(alu_i2),
    .shamt(shiftmux_o),
    .data_o(shifter_o)
    );

endmodule
