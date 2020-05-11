// Author:

module shifter(
		leftRight,
    data_i,
    shamt,
    data_o
    );

//I/O ports
input  leftRight;
input  [32-1:0] data_i;
input  [5-1:0] shamt;
output [32-1:0] data_o;

reg [32-1:0] data_o;

always@(*)
	begin
		if(leftRight==0)data_o=data_i<<16;
		else data_o=data_i>>shamt;
	end

endmodule
