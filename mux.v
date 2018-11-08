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
