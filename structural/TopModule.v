// Module Top nối 2 BusDriver vào chung 1 shared_bus
module TopModule (
    input wire En1, En2,
    input wire [7:0] Data1, Data2,
    output wire [7:0] shared_bus  // Hoặc khai báo kiểu tri [7:0] shared_bus
);
    // module con
    BusDriver dev1 (
        .Enable(En1),
        .DataIn(Data1),
        .DataBus(shared_bus) // Nối chung vào shared_bus
    );

    // module con
    BusDriver dev2 (
        .Enable(En2),
        .DataIn(Data2),
        .DataBus(shared_bus) // Nối chung vào shared_bus
    );
endmodule