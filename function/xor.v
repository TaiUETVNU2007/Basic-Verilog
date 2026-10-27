module xor (
    input in1 , in2 ;
    output reg out
)
    function Inhibit ;
      input a,b;
      Inhibit = a & ~b ;
    endfunction
    always @(*) begin :IB
        reg inh1 , inh2;
        inh1 = Inhibit(in1 , in2);
        inh2 = Inhibit(in2 , in1);
        out = inh1 | inh2;
    end
endmodule    