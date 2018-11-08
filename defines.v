//32 BIT INSTRUCTION BREAKDOWN DEFINITIONS
'define opcode	  ins[31:26] //opcode	
'define rs        ins[25:21] //first register
'define rt	 	  ins[20:16] //second register
'define rd	  	  ins[15:11] //register destination
'define shamt	  ins[10:6]  //shift amount
'define funct	  ins[5:0]   //function			   
'define address   ins[15:0]  //address


//OP CODE DEFINITIONS
'define addi 'b001000  //add immediate op code value
'define lw   'b100011  //load word op code value
'define sw   'b101011  //store word op code value	
'define r    'b000000  //r-format op code value	

