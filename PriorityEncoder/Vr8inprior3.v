module Vr8inprior3 (
    input [7:0] I,
    output reg [2:0] A,
    output reg IDLE ,
    integer j
);
    always @(*) begin
        IDLE=1; A=0;
        for(j=0;j<=7;j++) 
            if (I[j]==1) begin IDLE = 0; A = j; end
    end
endmodule