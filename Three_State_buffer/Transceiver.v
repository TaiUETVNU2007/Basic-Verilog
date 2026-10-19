module transceiver (
    input [1:8] A, B,
    inout G_L , Dir
);
    assign A=(~G_L & ~Dir) ? B : 8'bz;
    assign B =(~G_L & Dir) ? A : 8'bz;
endmodule    