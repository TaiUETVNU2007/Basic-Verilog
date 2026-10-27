module SystemErrorBus (
    input  wire Mem_Error,  // Bộ nhớ báo lỗi (1)
    input  wire GPU_Error,  // Card màn hình báo lỗi (1)
    output wor  BusError    // Đường Bus báo lỗi chung kiểu Wired-OR
);
    // Tín hiệu BusError = Mem_Error | GPU_Error
    assign BusError = Mem_Error;
    assign BusError = GPU_Error;
endmodule