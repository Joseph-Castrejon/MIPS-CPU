`timescale 1ns/1ps

module alu_control_tb;
	reg [5:0] func_field;
	reg [1:0] aluOP;
	wire [3:0] control_input;
	
alu_control u0(
	.func_field(func_field),
	.aluOP (aluOP),
	.control_input (control_input)
);

initial
	begin
	
			aluOP = 2'b10;
		#2
			func_field = 6'b100000;
		#2
			func_field = 6'b100010;
		#2
			func_field = 6'b100100;
		#2
			func_field = 6'b100101;
		#2
			func_field = 6'b100111;
		#2
			func_field = 6'b101010;
		#2
			func_field = 6'b100110;
		#2	
			aluOP = 2'b00;
		#10
			$finish;
	end
endmodule