// Author:0716029 王吉磊 0716081 葉晨

module Sign_Extend(
    data_i,
    data_o
    );

//I/O ports
input   [16-1:0] data_i;
output  [32-1:0] data_o;

//Internal Signals
reg     [32-1:0] data_o;

//Sign extended
always @(*)
	begin
		data_o[15:0] = data_i[15:0];
		
		if(data_i[15]==1'b1) data_o[31:16] = 16'b1111111111111111;
		else data_o[31:16] = 16'b0000000000000000;
	end

endmodule
