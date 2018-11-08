`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:05:14 11/19/2015
// Design Name:   Project
// Module Name:   C:/Users/siu850595480/mips2/Project_tb.v
// Project Name:  mips2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Project
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Project_tb;

	integer i = 0;
	parameter NUM_IM = 7; //change to number of instructions you want executed (this value is for test_prog1)
	// Inputs
	reg reset;
	reg clk;

	// Outputs
	wire [4:0] PCOut;
	wire [31:0] CurrentInstr;
	wire [31:0] AluInA;
	wire [31:0] AluInB;
	wire [31:0] AluResult;
	wire [31:0] RegFileWriteData;
	wire Zero;

	// Instantiate the Unit Under Test (UUT)
	// Replace Project by your top module name
	Project uut (
		.reset(reset),
		.clk(clk), 
		.PCOut(PCOut), 
		.CurrentInstr(CurrentInstr), 
		.AluInA(AluInA), 
		.AluInB(AluInB), 
		.AluResult(AluResult), 
		.RegFileWriteData(RegFileWriteData), 
		.Zero(Zero)
	);

	initial begin
		// Initialize Inputs
		reset = 1;
	
		clk = 0;
        
		// Add stimulus here
		#2
			reset = 0;
		
		//for (i = 0; i <= NUM_IM + 1; i = i + 1) 
		//begin
		//	always@(posedge clk)
				
		//end

		#200 $finish;

	end
	
	always begin
		 #4 clk <= ~clk;

	end
      
endmodule

