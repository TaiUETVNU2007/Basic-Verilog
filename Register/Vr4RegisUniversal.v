module Vr4RegisUniversal (
    input            CLK, 
    input            CLR,   // Synch clear (xóa đồng bộ)
    input            Lin,   // Input dịch từ bên trái vào MSB (Shift Right)
    input            Rin,   // Input dịch từ bên phải vào LSB (Shift Left)
    input      [1:0] SEL,   // Mã chọn chức năng
    input      [3:0] D,     // Dữ liệu nạp song song
    output reg [3:0] Q
);

    // Định nghĩa tham số trạng thái điều khiển
    parameter HOLD        = 2'b00,
              SHIFT_LEFT  = 2'b01,
              SHIFT_RIGHT = 2'b10, 
              LOAD        = 2'b11;

    always @(posedge CLK) begin
        if (CLR) begin
            Q <= 4'b0000;
        end else begin
            case (SEL)
                HOLD:        Q <= Q;                  // Giữ nguyên giá trị
                SHIFT_LEFT:  Q <= {Q[2:0], Rin};      // Dịch trái: Rin vào Q[0]
                SHIFT_RIGHT: Q <= {Lin, Q[3:1]};      // Dịch phải: Lin vào Q[3]
                LOAD:        Q <= D;                  // Nạp song song
                default:     Q <= Q;                  // Tránh chèn X không mong muốn
            endcase
        end
    end

endmodule
