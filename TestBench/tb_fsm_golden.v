`timescale 1ns/1ps

module tb_fsm_golden ();
    reg  clk;
    reg  rst;
    reg  A;
    wire Z1_golden;    
    wire Z1_pipelined; 
    integer i;
    integer error_count = 0;
    fsm_golden Golden_UUT (
        .clk (clk),
        .rst (rst),
        .A   (A),
        .Z1  (Z1_golden)
    );
    fsm_pipelined_lookahead Pipelined_UUT (
        .clk (clk),
        .rst (rst),
        .A   (A),
        .Z1  (Z1_pipelined)
    );
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // chu ki clock 10 ns 0-1-0-1
    end
    initial begin
        // reset lại hệ thống để làm sạch
        rst = 1; A = 0;
        #20;
        rst = 0; // bắt đầu chạy thử
        for (i = 1; i <= 1000; i = i + 1) begin
            @(posedge clk);
            A = $random & 1'b1; // lấy bit cuối thôi , thk random là lấy ngẫu nhiên số 32 bit có dấu
            #1; // Chờ 1ns để 2 khối cập nhật ngõ ra
            if (Z1_golden !== Z1_pipelined) begin
                $display("[ERROR] Lỗi tại chu kỳ %0d: Golden Z1=%b, Pipelined Z1=%b", 
                         i, Z1_golden, Z1_pipelined);
                error_count = error_count + 1;
            end
        end
        // Result summary
        if (error_count == 0)
            $display(" Đã so sánh 1000 chu kỳ, Golden Z1 và Pipelined Z1 KHỚP 100%%!");
        else
            $display(" Phát hiện %0d lỗi sai lệch!", error_count);

        $finish;
    end

endmodule