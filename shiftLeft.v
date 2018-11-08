module leftShift(instr,newInstr);
parameter bits = 25;


input [bits:0] instr;
newInstr [bits + 3 :0] newInstr;



assign newInstr = (instr << 2);


endmodule;


