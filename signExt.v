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