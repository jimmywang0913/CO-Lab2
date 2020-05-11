// Author:

module ALU_Ctrl(
        funct_i,
        ALUOp_i,
        ALUCtrl_o,
        result_o,
        leftRight_o,
        shift_o
        );

//I/O ports
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;
output		result_o;
output		leftRight_o;
output		shift_o;

//Internal Signals
reg        [4-1:0] ALUCtrl_o;
reg		result_o;
reg		leftRight_o;
reg		shift_o;

//Select exact operation
always@(*)
	begin
		if(ALUOp_i==3'b000) //r-type
			begin
				result_o=1'b0;
				leftRight_o=1'b0; 
				shift_o=1'b0; 
				
				if(funct_i==6'b100001) //add
					ALUCtrl_o=4'b0010; //(add)
				else if(funct_i==6'b100011) //sub
					ALUCtrl_o=4'b0110; //(sub)
				else if(funct_i==6'b100100) //and
					ALUCtrl_o=4'b0000; //(and)
				else if(funct_i==6'b100101) //or
					ALUCtrl_o=4'b0001; //(or)
				else if(funct_i==6'b101010) //slt
					ALUCtrl_o=4'b0111; //(slt)
				else if(funct_i==6'b000011) //sra
					begin
						ALUCtrl_o=4'b0000; //(xxx)
						result_o=1'b1;
						leftRight_o=1'b1;
						shift_o=1'b0;
					end
				else if(funct_i==6'b000111) //srav
					begin
						ALUCtrl_o=4'b0000; //(xxx)
						result_o=1'b1;
						leftRight_o=1'b1;
						shift_o=1'b1;
					end
			end
		else if(ALUOp_i==3'b001) //addi
			begin
				ALUCtrl_o=4'b0010; //(add)
				result_o=1'b0;
				leftRight_o=1'b0; //xxx
				shift_o=1'b0; //xxx
			end
		else if(ALUOp_i==3'b010) //sltui
			begin
				ALUCtrl_o=4'b0111; //(slt)
				result_o=1'b0;
				leftRight_o=1'b0; //xxx
				shift_o=1'b0; //xxx
			end
		else if(ALUOp_i==3'b011) //beq
			begin
				ALUCtrl_o=4'b0110; //(sub)
				result_o=1'b0; //xxx
				leftRight_o=1'b0; //xxx
				shift_o=1'b0; //xxx
			end
		else if(ALUOp_i==3'b100) //bne
			begin
				ALUCtrl_o=4'b0110; //(sub)
				result_o=1'b0; //xxx
				leftRight_o=1'b0; //xxx
				shift_o=1'b0; //xxx
			end
		else if(ALUOp_i==3'b101) //lui
			begin
				ALUCtrl_o=4'b0000; //xxx
				result_o=1'b1; 
				leftRight_o=1'b0; 
				shift_o=1'b0; //xxx
			end
		else if(ALUOp_i==3'b110) //ori
			begin
				ALUCtrl_o=4'b0001; //(or)
				result_o=1'b0; 
				leftRight_o=1'b0; //xxx
				shift_o=1'b0; //xxx
			end
	end

endmodule
