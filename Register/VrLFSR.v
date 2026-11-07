module VrLFSR #(
    parameter N = 8,
    parameter FE = 8'b00011101,
    parameter INIT = 8'b00000001
)(
    input CLK, RESET, RUN,
    output reg [N-1:0] Q
);   
    reg XN;
    integer i;

    always @(posedge CLK) begin
        if (RESET) begin
            Q <= INIT;
        end
        else if (RUN) begin
            XN = 0;
            for (i = 0; i < N; i = i + 1) begin
                if (FE[i]) begin
                    XN = XN ^ Q[i];
                end
            end
            Q <= {XN, Q[N-1:1]};
        end
    end
endmodule