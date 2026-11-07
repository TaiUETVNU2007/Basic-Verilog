`timescale 1ns / 1ps
module tb_Vr4RegisUniversal;
    // 1. Tín hiệu kết nối với DUT
    reg        CLK;
    reg        CLR;
    reg        Lin; // đẩy vào MSb
    reg        Rin;// đẩy vào LSB
    reg  [1:0] SEL;
    reg  [3:0] D;
    wire [3:0] Q;
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
    // Function test cờ lia
    task clear();
        begin
            @(negedge CLK);
            CLR = 1'b1;
            @(negedge CLK);
            CLR = 1'b0;
        end
    endtask
    // Task Nạp song song (LOAD)
    task load(input [3:0] data_in);
        begin
            @(negedge CLK);
            SEL = 2'b11; // LOAD
            D   = data_in;
            @(negedge CLK);
            SEL = 2'b00; // Trở về HOLD
        end
    endtask
    // Task Cấu hình chế độ
    task set(input [1:0] sel, input lin, input rin);
        begin
            @(negedge CLK);
            SEL = sel;
            Lin = lin;
            Rin = rin;
        end
    endtask
    initial begin
        // Khởi tạo trạng thái ban đầu
        CLK = 0; CLR = 0; Lin = 0; Rin = 0;
        SEL = 2'b00; D = 4'b0000;
        $display("Start");
        // test1 cờ lia
        clear();
        #1;
        if (Q !== 4'b0000) $error("Fail test 1: cờ lia thất bại");
        else              $display("Pass test 1: cờ lia thành công.");

        // test2 nạp song song và phải đảm bảo toggle Data_in
        load(4'b1010);
        #1;
        if (Q !== 4'b1010) $error("Fail test 2: nạp song song thất bại");
        else              $display("Pass test 2: nạp song song thành công.");

        load(4'b0101);
        #1;
        if (Q !== 4'b0101) $error("Fail test 3: nạp song song thất bại");
        else              $display("Pass test 3: nạp song song thành công.");

        // test3 hold
        set_mode(2'b00, 0, 0); // HOLD
        repeat (2) @(posedge CLK);
        #1;
        if (Q !== 4'b0101) $error("Fail test 4: HOLD làm thay đổi giá trị Q!");
        else              $display("Pass test 4: Hold giữ nguyên giá trị thành công.");

        // test 4: Shift Left (Dịch trái, Rin đẩy vào LSB) 
        // Dịch Rin=1 liên tục 4 lần để đầy 4'b1111 vào Q
        $display("test shift left liên tục 4 lần dịch");
        set_mode(2'b01, 0, 1); // SHIFT_LEFT, Rin = 1
        repeat (4) @(posedge CLK); // vì vẫn chủ động giữ setmode ở các con Sel , con Rin nên Q sẽ dịch liên tục 4 lần
        #1;
        if (Q !== 4'b1111) $error("Fail test 5: Shift Left Rin=1 thất bại (Q=%b)!", Q);
        else              $display("Pass test 5: Shift Left Rin=1 thành công.");

        // Dịch Rin=0 liên tục 4 lần để đẩy 4'b0000 vào Q
        set_mode(2'b01, 0, 0); // Rin = 0
        repeat (4) @(posedge CLK);
        #1;
        if (Q !== 4'b0000) $error("Fail test 6: Shift Left Rin=0 thất bại!");
        else              $display("Pass test 6: Shift Left Rin=0 thành công.");

        // --- TEST 5: Shift Right (Dịch phải, Lin đẩy vào MSB) ---
        // Dịch Lin=1 liên tục 4 lần để đẩy 4'b1111 vào Q
        $display("test shift right liên tục 4 lần dịch");
        set_mode(2'b10, 1, 0); // SHIFT_RIGHT, Lin = 1
        repeat (4) @(posedge CLK);
        #1;
        if (Q !== 4'b1111) $error("Fail test 7: Shift Right Lin=1 thất bại (Q=%b)!", Q);
        else              $display("Pass test 7: Shift Right Lin=1 thành công.");

        // test 6 check độ ưu tiên của clr
        @(negedge CLK);
        CLR = 1; SEL = 2'b11; D = 4'b1111; // Bật đồng thời CLR và LOAD
        @(negedge CLK);
        #1;
        if (Q === 4'b0000) $display("Pass test 8: CLR có độ ưu tiên cao nhất.");
        else              $error("Fail test 8: Tín hiệu CLR bị đè bởi LOAD!");
        $finish;
    end
endmodule