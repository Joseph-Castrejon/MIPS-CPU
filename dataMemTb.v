module dataMemTb;
reg memread;
reg memwrite;
reg [31:0] address;
reg [31:0] writeData;
wire [31:0] readData;

dataMem u0(.writeData(writeData),.address(address),.readdata(readData),.memread(memread),.memwrite(memwrite));

initial
	begin
			
			memwrite = 1;
			memread = 0;
			address = 10;
			writeData = 200;
		#5
			memwrite = 0;
			memread = 1;
		#5	
			memread = 0;
			address = 0;
		#5
			memread <= 1;
			address <= 10;
			
		#5
			$finish;
		end

	
	
	
endmodule
