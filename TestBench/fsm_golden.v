module fsm_golden (
    input  wire clk,
    input  wire rst,
    input  wire A,
    output reg  Z1
);
    localparam S_RESET = 2'b00, S_OK = 2'b01;
    reg [1:0] current_state, next_state;

    // 1. State Register
    always @(posedge clk or posedge rst) begin
        if (rst) current_state <= S_RESET;
        else     current_state <= next_state;
    end

    // 2. Next State Logic
    always @(*) begin
        case (current_state)
            S_RESET: next_state = (A) ? S_OK : S_RESET;
            S_OK:    next_state = S_RESET;
            default: next_state = S_RESET;
        endcase
    end

    // 3. Output Logic (Tổ hợp từ current_state)
    always @(*) begin
        Z1 = (current_state == S_OK);
    end
endmodule