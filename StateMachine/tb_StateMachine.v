`timescale 1ns / 1ps

module tb_StateMachine();

    // 1. Khai báo tín hiệu kết nối với Module Under Test (MUT)
    reg CLOCK;
    reg A;
    reg B;
    wire Z;

    // 2. Khởi tạo Module Under Test (MUT)
    VrSMex uut (
        .CLOCK(CLOCK),
        .A(A),
        .B(B),
        .Z(Z)
    );

    // 3. Tạo xung clock (chu kỳ 10ns -> tần số 100MHz)
    always #5 CLOCK = ~CLOCK;

    // 4. Kịch bản kiểm thử (Test Scenario)
    initial begin
        // --- Bước 1: Khởi tạo giá trị ban đầu ---
        CLOCK = 0;
        A = 0;
        B = 0;

        // Chờ 15ns để hệ thống ổn định
        #15;

        // --- Bước 2: Kiểm thử chuyển trạng thái từ INIT sang A1 ---
        // Tại INIT, nếu A = 1 -> Snext = A1
        A = 1; B = 0;
        #10; // Chờ 1 chu kỳ clock để cập nhật trạng thái

        // --- Bước 3: Kiểm thử chuyển trạng thái từ A1 sang OK1 ---
        // Tại A1, nếu A = 1 -> Snext = OK1
        A = 1; B = 0;
        #10;

        // --- Bước 4: Kiểm thử đầu ra Z tại OK1 và chuyển tiếp ---
        // Tại OK1, Z phải bằng 1 (kiểm tra đầu ra Moore)
        // Nếu A = 0 và B = 0 -> Snext = A0
        A = 0; B = 0;
        #10;

        // --- Bước 5: Kiểm thử chuyển từ A0 sang OK0 ---
        // Tại A0, nếu A = 0 -> Snext = OK0
        A = 0; B = 0;
        #10;

        // --- Bước 6: Kiểm thử tín hiệu default / reset ngầm ---
        // Đưa các lối vào về trạng thái quay lại INIT
        A = 0; B = 1;
        #20;

        // --- Kết thúc mô phỏng ---
        $display("Mô phỏng hoàn tất thành công!");
        $finish;
    end

    // 5. Theo dõi và in giá trị ra Console (Monitor)
    initial begin
        $monitor("Time = %0t | CLOCK = %b | A = %b | B = %b | State(Sreg) = %b | Output Z = %b", 
                 $time, CLOCK, A, B, uut.Sreg, Z);
    end

    // 6. Xuất dạng sóng ra file VCD (dùng xem trên ModelSim/GTKWave)
    initial begin
        $dumpfile("tb_VrSMex.vcd");
        $dumpvars(0, tb_VrSMex);
    end

endmodule
