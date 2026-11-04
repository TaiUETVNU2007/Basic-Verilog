module Vr4binaryCounter(
    input CLK , CLR ,
    input ENT , ENP,
    input LD ,
    input [3:0] D,
    output reg [3:0] Q,
    output RCO
); 
    reg [3:0] Q_Not;
    assign Q_Not = ~Q;
    assign RCO = (Q_Not==4'b0000 && ENT==1'b1) ? 1'b1 : 1'b0;
    always @(posedge CLK) begin
        if (CLR=='b1) begin
            Q<=4'b0000;
        end
        else if (LD==1'b1) begin
            Q<=D;
        end
        else if (ENT==1'b1 && ENP==1'b1) begin
            Q<=Q+1'b1;
        end
    end
endmodule