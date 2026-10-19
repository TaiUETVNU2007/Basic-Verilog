module SystemInterruptBus (
    input  wire Device1_IRQ_n, // Thiết bị 1 yêu cầu ngắt (kéo 0)
    input  wire Device2_IRQ_n, // Thiết bị 2 yêu cầu ngắt (kéo 0)
    output wand System_IRQ_n   // Đường Bus cờ ngắt kiểu Wired-AND
);
    // Nối trực tiếp cả 2 thiết bị vào chung 1 đường dây
    // Tín hiệu ra System_IRQ_n sẽ bằng (Device1_IRQ_n & Device2_IRQ_n)
    assign System_IRQ_n = Device1_IRQ_n;
    assign System_IRQ_n = Device2_IRQ_n;
endmodule