module xor (
    inout in1 , in2 ;
    output reg out 
)
   function inhibit ;
       input a , b ;
       begin
           inhibit = a & ~b ;
       end
    endfunction
    always @(*) begin :IB
        reg inh1 , inh2;
        inh1 = inhibit(in1 , in2);
        inh2 = inhibit(in2 , in1);
        out = inh1 | inh2;
    end
endmodule        