module Vr8RegisCLKOE(
    input [7:0] D,
    input CLK , OE_L,
    output wire [7:0] Q
);
    reg  [7:0] current_state;
    assign Q=(OE_L==1'b0) ? current_state : 8'bz;
    always @(posedge CLK) begin
        current_state<=D;
    end
endmodule           