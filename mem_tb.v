`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:41:47 03/30/2017
// Design Name:   ins_mem
// Module Name:   F:/School/329 - Computer Org. and Design/Lab5/mem_tb.v
// Project Name:  Ins_Mem
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ins_mem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mem_tb;

	// Inputs
	reg clk;
	reg [7:0] pc;

	// Outputs
	wire regdst;
	wire alusrc;
	wire memtoreg;
	wire regwrite;
	wire memread;
	wire memwrite;
	wire [1:0] aluop;

	// Instantiate the Unit Under Test (UUT)
	ins_mem uut (
		.clk(clk), 
		.pc(pc), 
		.regdst(regdst), 
		.alusrc(alusrc), 
		.memtoreg(memtoreg), 
		.regwrite(regwrite), 
		.memread(memread), 
		.memwrite(memwrite), 
		.aluop(aluop)
	);
	
	always
		#2 clk = ~clk;

	initial begin
		$dumpfile("test.vcd");
		$dumpvars;

		// Initialize Inputs
		clk = 0;
		pc = 0;
		
		#8 
		pc = 1;

		#8
		pc = 2;
		
		#8 
		pc = 3;
		
		#8
		pc = 0;
		
		#8 
		pc = 1;

		#8
		pc = 2;
		
		#8 
		pc = 3;
		
		// Wait 100 ns for global reset to finish
		#10 $finish;
        
		// Add stimulus here

	end
      
endmodule

