// Author:

module branchornot(
    data0_i,
    data1_i,
    data2_i,
    data3_i,
	data4_i,
	data5_i,
    data_o
    );

parameter size = 0;

//I/O ports
input   data0_i;
input   data1_i;
input   data2_i;
input   data3_i;
input   data4_i,data5_i;
output  data_o;

//Internal Signals
assign data_o=(data0_i&data1_i&data2_i)|(data3_i& ~data4_i&~data5_i);

endmodule
