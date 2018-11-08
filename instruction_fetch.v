
//instruction memory module

module ins_fetch(ins,clk,pc);

parameter width = 32; 	//datapath width

input [7:0] pc;
input clk;
output reg [width - 1:0] ins;


reg [width - 1:0] mem_a[255:0];	


//instruction memory assignments 
always@(posedge clk)
	begin
		mem_a[0] <= 31'b001000000000000000000000000000; //addi
		mem_a[1] <= 31'b100011000000000000000000000000; //lw	
		mem_a[2] <= 31'b101011000000000000000000000000; //sw	
		mem_a[3] <= 31'b000000000000000000000000000000; //r
	end
//memory to instruction

always@(posedge clk)
	begin		
		[31:0] ins <= mem_a[pc];
	end	
endmodule

