// Author:0716029 王吉磊 0716081 葉晨

module Decoder(
    instr_op_i,
    RegWrite_o,
    ALU_op_o,
    ALUSrc_o,
    RegDst_o,
    Branch_o
    );

//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output [2-1:0] ALUSrc_o;
output         RegDst_o;
output [2-1:0] Branch_o;

//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg    [2-1:0] Branch_o;

always @(*)
	begin
		if(instr_op_i == 6'b000000) //r-type
			begin
				ALU_op_o=3'b000;
				ALUSrc_o=2'b00;
				RegWrite_o=1'b1;
				RegDst_o=1'b1;
				Branch_o=2'b00;
			end
		else if(instr_op_i == 6'b001000) //addi
			begin
				ALU_op_o=3'b001;
				ALUSrc_o=2'b01;
				RegWrite_o=1'b1;
				RegDst_o=1'b0;
				Branch_o=2'b00;
			end
		else if(instr_op_i == 6'b001011) //sltiu
			begin
				ALU_op_o=3'b010;
				ALUSrc_o=2'b01;
				RegWrite_o=1'b1;
				RegDst_o=1'b0;
				Branch_o=2'b00;
			end
		else if(instr_op_i == 6'b000100) //beq
			begin
				ALU_op_o=3'b011;
				ALUSrc_o=2'b00;
				RegWrite_o=1'b0;
				RegDst_o=1'b0; //whatever
				Branch_o=2'b11;
			end
		else if(instr_op_i == 6'b000101) //bne
			begin
				ALU_op_o=3'b100;
				ALUSrc_o=2'b00;
				RegWrite_o=1'b0;
				RegDst_o=1'b0; //whatever
				Branch_o=2'b01;
			end
		else if(instr_op_i == 6'b001111) //lui
			begin
				ALU_op_o=3'b101;
				ALUSrc_o=2'b01; //whatever
				RegWrite_o=1'b1;
				RegDst_o=1'b0;
				Branch_o=2'b00;
			end
		else if(instr_op_i == 6'b001101) //ori
			begin
				ALU_op_o=3'b110;
				ALUSrc_o=2'b10;
				RegWrite_o=1'b1;
				RegDst_o=1'b0;
				Branch_o=2'b00;
			end
	
	end

endmodule
