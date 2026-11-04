module VrDLatchCe(
    input D ,G , GE , CLR,
    output reg Q
);
    always @(*) begin
        if (CLR==1'b1) b
            Q<=1'b0;
        else if (GE==1'b1 && G==1'b1) 
            Q<=D;
        else if (GE==1'b0 || G==1'b0)
            Q<=Q;
    end
endmodule