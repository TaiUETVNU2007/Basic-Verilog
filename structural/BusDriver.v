// Module bộ đệm 3 trạng thái phát dữ liệu lên Bus
module BusDriver (
    input  wire       Enable,  // Tín hiệu cho phép phát
    input  wire [7:0] DataIn,  // Dữ liệu nội bộ từ CPU
    output tri  [7:0] DataBus  // Cổng nối thẳng ra Data Bus dùng chung
);

    // Khi Enable = 1, phát dữ liệu ra Bus. Khi Enable = 0, thả trôi (High-Z)
    assign DataBus = Enable ? DataIn : 8'bz;

endmodulekhôn