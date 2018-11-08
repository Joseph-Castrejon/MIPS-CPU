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
						control_input = 4'b0010;
					6'b100010:	
						control_input = 4'b0110;
					6'b100100:
						control_input = 4'b0000;
					6'b100101:
						control_input = 4'b0001;
					6'b100111:
						control_input = 4'b1100;
					6'b101010:
						control_input = 4'b0111;
					6'b100110:
						control_input = 4'b1101;
				endcase
			end
		else
			begin
				$monitor("The case statement is not working correctly");
			end
	end
endmodule