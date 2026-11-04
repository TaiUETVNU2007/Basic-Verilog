module VrDLatch(
    input D,
    input G,
    output reg Q
);
    always @(*) begin
        if (G==1'b1) begin
            Q<=D;
        else if (G==1'b0) begin
            Q<=Q;
        end
    end
endmodule