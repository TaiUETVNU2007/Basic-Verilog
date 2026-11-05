`timescale 1ns / 1ps

module tb_Vr4RegisUniversal;

    // 1. Tín hiệu kết nối với DUT
    reg        CLK;
    reg        CLR;
    reg        Lin;
    reg        Rin;
    reg  [1:0] SEL;
    reg  [3:0] D;
    wire [3:0] Q;

    // 2. Gọi module DUT
    Vr4RegisUniversal dut (
        .CLK(CLK),
        .CLR(CLR),
        .Lin(Lin),
        .Rin(Rin),
        .SEL(SEL),
        .D(D),
        .Q(Q)
    );

    // 3. Tạo xung Clock (chu kỳ 10ns)
    always #5 CLK = ~CLK; 
    // Task Reset
    task apply_clear();
        begin
            @(negedge CLK);
            CLR = 1'b1;
            @(negedge CLK);
            CLR = 1'b0;
        end
    endtask
    // Task Nạp song song (LOAD)
    task apply_load(input [3:0] data_in);
        begin
            @(negedge CLK);
            SEL = 2'b11; // LOAD
            D   = data_in;
            @(negedge CLK);
            SEL = 2'b00; // Trở về HOLD
        end
    endtask
    // Task Cấu hình chế độ
    task set_mode(input [1:0] mode_sel, input lin_val, input rin_val);
        begin
            @(negedge CLK);
            SEL = mode_sel;
            Lin = lin_val;
            Rin = rin_val;
        end
    endtask
    initial begin
        // Khởi tạo trạng thái ban đầu
        CLK = 0; CLR = 0; Lin = 0; Rin = 0;
        SEL = 2'b00; D = 4'b0000;
        $display("=== BẮT ĐẦU TESTBENCH Vr4RegisUniversal ===");
        // --- TEST 1: Clear ---
        apply_clear();
        #1;
        if (Q !== 4'b0000) $error("[FAIL] Clear không đưa Q về 0!");
        else              $display("[PASS] Clear thành công.");

        // --- TEST 2: Load (Kiểm tra Toggle Coverage với 2 mẫu bit đối lập) ---
        apply_load(4'b1010);
        #1;
        if (Q !== 4'b1010) $error("[FAIL] Load 1010 thất bại (Q=%b)!", Q);
        else              $display("[PASS] Load 1010 thành công.");

        apply_load(4'b0101);
        #1;
        if (Q !== 4'b0101) $error("[FAIL] Load 0101 thất bại (Q=%b)!", Q);
        else              $display("[PASS] Load 0101 thành công.");

        // --- TEST 3: Hold State ---
        set_mode(2'b00, 0, 0); // HOLD
        repeat (2) @(posedge CLK);
        #1;
        if (Q !== 4'b0101) $error("[FAIL] HOLD làm thay đổi giá trị Q!");
        else              $display("[PASS] Hold giữ nguyên giá trị thành công.");

        // --- TEST 4: Shift Left (Dịch trái, Rin đẩy vào LSB) ---
        // Dịch Rin=1 liên tục 4 lần để đầy 4'b1111 vào Q
        $display("--- Testing Shift Left ---");
        set_mode(2'b01, 0, 1); // SHIFT_LEFT, Rin = 1
        repeat (4) @(posedge CLK);
        #1;
        if (Q !== 4'b1111) $error("[FAIL] Shift Left Rin=1 thất bại (Q=%b)!", Q);
        else              $display("[PASS] Shift Left Rin=1 thành công.");

        // Dịch Rin=0 liên tục 4 lần để đẩy 4'b0000 vào Q
        set_mode(2'b01, 0, 0); // Rin = 0
        repeat (4) @(posedge CLK);
        #1;
        if (Q !== 4'b0000) $error("[FAIL] Shift Left Rin=0 thất bại!");
        else              $display("[PASS] Shift Left Rin=0 thành công.");

        // --- TEST 5: Shift Right (Dịch phải, Lin đẩy vào MSB) ---
        // Dịch Lin=1 liên tục 4 lần để đẩy 4'b1111 vào Q
        $display("--- Testing Shift Right ---");
        set_mode(2'b10, 1, 0); // SHIFT_RIGHT, Lin = 1
        repeat (4) @(posedge CLK);
        #1;
        if (Q !== 4'b1111) $error("[FAIL] Shift Right Lin=1 thất bại (Q=%b)!", Q);
        else              $display("[PASS] Shift Right Lin=1 thành công.");

        // --- TEST 6: Độ ưu tiên của Clear (CLR Priority) ---
        @(negedge CLK);
        CLR = 1; SEL = 2'b11; D = 4'b1111; // Bật đồng thời CLR và LOAD
        @(negedge CLK);
        #1;
        if (Q === 4'b0000) $display("[PASS] CLR có độ ưu tiên cao nhất.");
        else              $error("[FAIL] Tín hiệu CLR bị đè bởi LOAD!");
        $finish;
    end

endmodule