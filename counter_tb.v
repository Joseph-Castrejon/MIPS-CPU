module fourbitTest;
reg Resetn, Clock, E;
wire [3:0] Q;

upcount c0(.Clock (Clock),.Resetn (Resetn),.E(E),.Q(Q));

always
    #2 Clock = ~Clock;
    
     initial
        begin
            $dumpfile("counter.vcd");
            $dumpvars;
            Clock = 0;
            Resetn = 0;
            E = 0;
            #2
            E = 1;
            Resetn = 1;
            #60
            E = 0;

        end
    



    initial
        #100 $finish;

endmodule
