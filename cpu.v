module alu_control(func_field,aluOP,control_input);
input [5:0] func_field;
input [1:0] aluOP;

output reg [3:0]control_input;

always @ (func_field or aluOP)
	begin
		if(aluOP == 2'b00)
			begin
				control_input = 4'b0010;
			end
		else if(aluOP == 2'b10)
			begin	
				case(func_field)
					6'b100000:
						control_input = 4'b0010; //add immediate, load word, or store word 
					6'b100010:	
						control_input = 4'b0110; //sub
					6'b100100:
						control_input = 4'b0000; // and
					6'b100101:
						control_input = 4'b0001; // or
					6'b100111:
						control_input = 4'b1100; // nor
					6'b101010:
						control_input = 4'b0111; //set less than 
					6'b100110:
						control_input = 4'b1101; // nand
					default:
						$display("Instruction opcode not in ALU Control");
				endcase
			end
		end
endmodule


module ALU(A,B,CLK,RST,dOut,OP,Zero);
parameter bits = 32;
input [bits-1:0] A;
input [bits-1:0] B;
input [3:0] OP;
input CLK,RST;
output reg [bits-1:0] dOut;
output Zero;




always@(posedge CLK or posedge RST)
begin
	
		 //Case statement for OP code selection
		case(OP)
		
			4'b0000:
				dOut <= A & B;	
			
			4'b0001:
				dOut <= A | B; 
		
			4'b0010:
				dOut <= A + B;

			4'b0110:
				dOut <= A - B;
			4'b0111:
				if(A > B)
					begin
						dOut <= 32'b00000000000000000000000000000001;
					end
				else	
					begin
                dOut <= 32'b00000000000000000000000000000000;	
					end
			4'b1100: dOut <= !(A | B); 
			4'b1101: dOut <= !(A & B); 
			default:$display("Error in OP code");
			endcase
end


assign Zero = 0;


endmodule


//instruction fetch module

module ins_fetch(ins,clk,pc);

parameter width = 32; 	//datapath width

input [4:0] pc;
input clk;
output [width - 1:0] ins;


reg [width - 1:0] mem_a[width-1:0];	


//instruction memory assignments 
always@(posedge clk)
	begin
		mem_a[0] <= 32'b00100000000010000000000000000101; 	
		mem_a[1] <= 32'b00100000000010010000000000000110; 	
		mem_a[2] <= 32'b00000001000010010101100000100000; 	
		mem_a[3] <= 32'b10101100000010110000000000000000; 
		mem_a[4] <= 32'b10001100000011000000000000000000; 
		mem_a[5] <= 32'b00000001000011000110100000100100;	
		mem_a[6] <= 32'b00000001000011010111000000101010; 
		mem_a[7] <= 32'b00000000000000000000000000000000;
		mem_a[8] <= 32'b00000000000000000000000000000000; 
		mem_a[9] <= 32'b00000000000000000000000000000000;
		mem_a[10] <= 32'b00000000000000000000000000000000; 
		mem_a[11] <= 32'b00000000000000000000000000000000;
		mem_a[12] <= 32'b00000000000000000000000000000000; 
		mem_a[13] <= 32'b00000000000000000000000000000000;
		mem_a[14] <= 32'b00000000000000000000000000000000; 
		mem_a[15] <= 32'b00000000000000000000000000000000;
		mem_a[16] <= 32'b00000000000000000000000000000000; 
		mem_a[17] <= 32'b00000000000000000000000000000000;
		mem_a[18] <= 32'b00000000000000000000000000000000; 
		mem_a[19] <= 32'b00000000000000000000000000000000;
		mem_a[20] <= 32'b00000000000000000000000000000000;
		mem_a[21] <= 32'b00000000000000000000000000000000;
		mem_a[22] <= 32'b00000000000000000000000000000000;
		mem_a[23] <= 32'b00000000000000000000000000000000;
		mem_a[24] <= 32'b00000000000000000000000000000000;
		mem_a[25] <= 32'b00000000000000000000000000000000;
		mem_a[26] <= 32'b00000000000000000000000000000000;
		mem_a[27] <= 32'b00000000000000000000000000000000;
		mem_a[28] <= 32'b00000000000000000000000000000000;
		mem_a[29] <= 32'b00000000000000000000000000000000;
		mem_a[30] <= 32'b00000000000000000000000000000000;
		mem_a[31] <= 32'b00000000000000000000000000000000;
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
          
		6'b001000:
		begin
			regdst <= 0;
			alusrc <= 1;
			memtoreg <= 0;
			regwrite <= 1;      //addi
			memread <= 0;
			memwrite <= 0;
			aluop <= 2'b00;
		end
		6'b100011:
			begin
			regdst <= 0;
			alusrc <= 1;
			memtoreg <= 1;
			regwrite <= 1;     //load word 
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
			memread <= 0;         //store word  
			memwrite <= 1;
			aluop <= 2'b00;
			end
		6'b000000:
			begin
			regdst <= 1;
			alusrc <= 0;
			memtoreg <= 0;
			regwrite <= 1;      //r-format
			memread <= 0;
			memwrite <= 0;
			aluop <= 2'b10;
			end
                



		default:
			$monitor("Error: Unknown Instruction");
		endcase 

end
	


endmodule

//INSTRUCTION MEMORY

module ins_mem(clk, pc,regdst,alusrc,memtoreg,regwrite,memread,memwrite,aluop,ins);

input [4:0] pc;
input clk;

output regdst,alusrc,memtoreg,regwrite,memread,memwrite;
output [1:0] aluop;
output [31:0] ins;


ins_fetch fetch( .ins(ins),
				 .clk (clk),
				 .pc(pc)
);

ins_dec decode(	.ins(ins),
				.clk(clk),
				.regdst(regdst),
				.alusrc(alusrc),
				.memtoreg(memtoreg),
				.regwrite(regwrite),
				.memread(memread),
				.memwrite(memwrite),
				.aluop(aluop)
);
	
endmodule


//REGISTER FILE




module regfile (
	input clk,
	input regwrite,
	input [4:0] wa,
	input [31:0] wd,
	input [4:0] rad1,
	input [4:0] rad2,
	output reg [31:0] rd1, rd2);
	reg [31:0] mem [0:31];
	integer i;
	
// Within initial block write a for loop from 0 to 31 and initialize clear all the register
// Write the always block to write input data wd to the memory when writereg is enabled
//use signal assignment statement (assign) to read data from meomory address given by respective address rad1 and rad2 and assign to outputs rd1 and rd2
// if memory address rad1 and rad2 are zero the outputs rad1 and rad2 should be zero 	
initial 
	begin
	
	for(i = 0; i < 32; i = i+1)
		begin
			mem[i] = 32'b0000000000000000000000000000000;
		end
	end
	
	always@(posedge clk)
		begin
			if(regwrite == 1)
				begin
					mem[wa] = wd;
				end
			if((rad1 == 0) && (rad2 == 0))
				begin
					rd1 <= 32'b0000000000000000000000000000000;
					rd2 <= 32'b0000000000000000000000000000000;
				end
			else if(rad1 == 0)
				begin
					rd1 <= 32'b0000000000000000000000000000000;
					rd2 <= mem[rad2];
				end
			else if(rad2 == 0)
				begin
					rd2 <= 32'b0000000000000000000000000000000;
					rd1 <= mem[rad1];
				end
			else		
				begin
					rd2 <= mem[rad2];
					rd1 <= mem[rad1];
				end
		end
	
	
endmodule 

//FOUR BIT COUNTER
module pc(Resetn, Clock, E, Q);
input Resetn, Clock;
input [4:0] E;
output reg [4:0] Q;
reg [1:0] a = 2'b00;


always @(posedge Resetn, posedge Clock)
	if (Resetn)
		Q <= 0;
	else
		begin
			if(a < 2'b10)
				a <= a + 2'b01;
			else
				begin
					a <= 2'b00;
					Q <= Q + 1;
				end
		end	


endmodule


//Accumulator
module Accumulator(datain, clk,Reset, Acc);
	 input clk, Reset;
	 input [4:0] datain;
	 output [4:0] Acc;
	 reg [4:0] A;
	

	//Write an always block that implements asynchronous reset and 
	always@(posedge clk or posedge Reset)
		begin
			if(Reset)
				begin
					A = 5'b00100;				
				end
			else
				begin
					A = A + datain;
				end
		end
		
	assign Acc = A;

endmodule


//SIGN EXTENSION
module signExt(ins,q);
input [15:0] ins;
output reg [31:0] q;

always@(ins)
begin
if(ins[15] == 1)
	begin
		q = {{16'b1111111111111111},ins[15:0]};
	end
else
	begin
		q = {{16{1'b0}},ins[15:0]};
	end
end
endmodule

module mux(a,b,sel,q);

parameter width = 32;

input sel;
input [width - 1:0] a;
input [width-1:0] b;
output reg [width - 1:0] q;

always@(sel or a or b)
	begin
		if(sel == 0)
			begin
				q = b; 
			end	
		else
			begin
				q = a;
			end
			
	end

endmodule




//DATA Memory

module dataMem(clk,writeData,address,readdata,memread,memwrite);
input clk,memread,memwrite;
input [31:0] address;
input [31:0] writeData;
output reg[31:0] readdata;
reg [31:0] memory[31:0];
integer i;

initial 
	begin
	
	for(i = 0; i < 32; i = i+1)
		begin
			memory[i] = 32'b0000000000000000000000000000000;
		end
	end


always@(posedge clk)
	begin
		if(memwrite == 1 && memread == 0)
			begin
				memory[address] = writeData;
			end
		else if(memwrite == 0 && memread == 1)
			begin 
				readdata = memory[address];
			end
		else	
			begin	
			
			$monitor("Memory not in use");			
							
			end
	end

endmodule


module Project(reset,clk,PCOut,CurrentInstr,AluInA,AluInB,AluResult,RegFileWriteData,Zero);
input clk,reset;

output [4:0] PCOut;
output [31:0] CurrentInstr;
output [31:0] AluInA;
output [31:0] AluInB;
output [31:0] AluResult;
output [31:0] RegFileWriteData;
output Zero;


wire memread,memtoreg,alusrc,regdst,memwrite,regwrite;
wire [1:0] aluop;
wire [31:0] signQ,readData1,readData2,aluRes,dataMem_read,write,reg_WriteData,dataMem_address;
wire [3:0] alu_contrInput;
wire [4:0] ins_writereg,acc,ins_address;



defparam mux1.width = 5;
defparam mux2.width = 32;
defparam mux3.width = 32;



mux mux1(.a(CurrentInstr[15:11]),
	.b(CurrentInstr[20:16]),
	.sel(regdst),
	.q(ins_writereg));

mux mux2(.a(signQ),
        .b(readData2),
        .sel(alusrc),
        .q(AluInB));

mux mux3(.a(dataMem_read),
         .b(AluResult),
         .sel(memtoreg),
         .q(RegFileWriteData)
);

pc pc0(
         .Resetn(reset),
         .Clock(clk), 
         .E(acc), 
         .Q(PCOut)
);

alu_control a0( 
         .func_field(CurrentInstr[5:0]),
         .aluOP(aluop),
         .control_input(alu_contrInput)
);

ALU a1(
        .A(AluInA),
        .B(AluInB),
        .CLK(clk),
        .RST(reset),
        .dOut(AluResult),
        .OP(alu_contrInput),
		  .Zero(Zero)
);

regfile r1(
 	    .clk(clk),
	    .regwrite(regwrite),
	    .wa(ins_writereg),
	    .wd(RegFileWriteData),
	    .rad1(CurrentInstr[25:21]),
	    .rad2(CurrentInstr[20:16]),
	    .rd1(AluInA), 
       .rd2(readData2)          
);
ins_mem m0(    	
					 .clk(clk),
                .pc(PCOut),
                .regdst(regdst),
                .alusrc(alusrc),
                .memtoreg(memtoreg),
                .regwrite(regwrite),
                .memread(memread),
                .memwrite(memwrite),
                .aluop(aluop),
					 .ins(CurrentInstr)
);
dataMem m1( .clk(clk),
	         .writeData(readData2),
            .address(AluResult),
            .readdata(dataMem_read),
            .memread(memread),
            .memwrite(memwrite)
);

Accumulator a2(
        .datain(PCOut),
        .clk(clk),
        .Reset(reset),
        .Acc(acc) 
);

signExt s0(
        .ins(CurrentInstr[15:0]),
        .q(signQ)

);


endmodule 
