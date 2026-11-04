`timescale 1ns / 1ps

module VrFFandLatchTB;

  // 1. Khai báo tín hiệu kết nối
  reg Tclk;
  reg D1, D2;
  reg G1, G2, GE;
  reg CLR, PR;
  wire [1:6] Q;

  // 2. Gọi (Instantiate) Module Cần Kiểm Trử (DUT - Device Under Test)
  VrFFandLatches UUT (
      .Tclk(Tclk),
      .D1(D1),
      .D2(D2),
      .G1(G1),
      .G2(G2),
      .GE(GE),
      .CLR(CLR),
      .PR(PR),
      .Q(Q)
  );

  // 3. Tạo Xung Nhịp Tclk (Chu kỳ 20ns)
  initial Tclk = 0;
  always begin
    #0.2 Tclk = 1;
    #10  Tclk = 0;
    #9.8 ;
  end

  // 4. Khởi tạo và Biến đổi Dữ liệu D1, D2 (Chu kỳ 15ns)
  initial begin
    D1 = 0; D2 = 1;
  end
  always begin
    #2  D1 = ~D1; D2 = ~D2;
    #5  D2 = ~D2;
    #5  D1 = ~D1;
    #3  ;
  end

  // 5. Điều khiển Tín hiệu Cho phép G1, G2
  initial begin
    G1 = 0; G2 = 0;
  end
  always begin
    #4  G1 = ~G1; G2 = ~G2;
    #20 G1 = ~G1;
    #10 G2 = ~G2;
    #10 G1 = ~G1;
    #16 ;
  end

  // 6. Điều khiển Tín hiệu Cho phép Toàn cục GE (Chu kỳ 60ns)
  initial GE = 0;
  always begin
    #2  GE = ~GE;
    #58 ;
  end

  // 7. Khởi tạo Tín hiệu Reset/Preset (CLR, PR) & Cấu hình Dump Waveform Cadence
  initial begin
    // Trạng thái ban đầu: Kích hoạt Reset & Preset để ép trạng thái mạch
    CLR = 1; 
    PR  = 1;

    #115;
    // Rút Reset và Preset về 0 để giải phóng mạch chạy bình thường
    CLR = 0; 
    PR  = 0;

    #300;

    // --- CẤU HÌNH DUMP WAVEFORM CHO CADENCE XCELIUM ---
    $shm_open("waves.shm"); // Mở database tạo thư mục waves.shm
    $shm_probe("AC");       // Probe toàn bộ các tín hiệu (A) và tầng con (C)
    $stop;
  end

endmodule