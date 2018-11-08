
//instruction memory module

module ins_fetch(ins,clk,pc);

parameter width = 32; 	//datapath width

input [7:0] pc;
input clk;
output [width - 1:0] ins;


reg [width - 1:0] mem_a[255:0];	


//instruction memory assignments 
always@(posedge clk)
	begin
		mem_a[0] <= 32'b00100000000000000000000000000000;  //addi ins
		mem_a[1] <= 32'b10001100000000000000000000000000; 	//load word ins
		mem_a[2] <= 32'b10101100000000000000000000000000; 	//store word	
		mem_a[3] <= 32'b00000000000000000000000000000000; 	//r-format
	end
//memory to instruction


		
	assign	ins = mem_a[pc];
	
endmodule


//instruction decode  module

module ins_dec(ins,clk,regdst,alusrc,memtoreg,regwrite,memread,memwrite,aluop);

parameter width = 32; 	//datapath width

input [width-1:0] ins;
input clk;

output reg regdst,alusrc,memtoreg,regwrite,memread,memwrite;
output reg [1:0] aluop;


always @ (posedge clk)
begin


	case(ins[31:26])
          
		6'b001000:begin
			regdst <= 0;
			alusrc <= 1;
			memtoreg <= 0;
			regwrite <= 1;
			memread <= 0;
			memwrite <= 0;
			aluop <= 2'b00;
			end
		6'b100011:
			begin
			regdst <= 0;
			alusrc <= 1;
			memtoreg <= 1;
			regwrite <= 1;
			memread <= 1;
			memwrite <= 0;
			aluop <= 2'b00;
			end
		6'b101011:
			begin
			regdst <= 1'bx;
			alusrc <= 1;
			memtoreg <= 1'bx;
			regwrite <= 0;
			memread <= 0;
			memwrite <= 1;
			aluop <= 2'b00;
			end
		6'b000000:
			begin
			regdst <= 1;
			alusrc <= 0;
			memtoreg <= 0;
			regwrite <= 1;
			memread <= 0;
			memwrite <= 0;
			aluop <= 2'b10;
			end
		default:
			$monitor("The case statement is not reading instruction correctly");
		endcase 

end
	


endmodule



module ins_mem(clk, pc,regdst,alusrc,memtoreg,regwrite,memread,memwrite,aluop);

input [7:0] pc;
input clk;

output regdst,alusrc,memtoreg,regwrite,memread,memwrite;
output [1:0] aluop;

wire [31:0] ins;

ins_fetch fetch( .ins(ins),.clk (clk), .pc(pc));
ins_dec decode(.ins(ins),.clk(clk),.regdst(regdst),.alusrc(alusrc),.memtoreg(memtoreg),.regwrite(regwrite),.memread(memread),.memwrite(memwrite),.aluop(aluop));
	
endmodule



