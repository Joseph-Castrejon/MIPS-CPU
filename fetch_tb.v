`timescale 1ns/1ps
module instr_test();

reg [7:0] pc;
reg clk;
reg [31:0] mem_a[255:0];

wire [31:0] ins;

always
	#2 clk = ~clk;

initial
	begin
		clk = 0;
	#2
		pc <= 0;
	#4
		pc <= 1;
	#4
		pc <= 2;
	#4
		pc <= 3;
	#4 $finish;
	
	end
endmodule