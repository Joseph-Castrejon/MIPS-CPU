module dataMem(writeData,address,readdata,memread,memwrite);
input memread;
input memwrite;
input [31:0] address;
input [31:0] writeData;
output reg[31:0] readdata;
reg [31:0] memory[31:0];

always@(memwrite or memread or address)
	begin
		if(memwrite == 1 && memread == 0)
			begin
				memory[address]	= writeData;
			end
		else if(memwrite == 0 && memread == 1)
			begin 
				assign readdata = memory[address];
			end
		else	
			begin	
			
			$monitor("Memory not in use");			
							
			end
	end

endmodule
