module threeState_driver(
    input G1_L, G2_L;
    input [1:8] A;
    output [1:8] Y
);
   assign Y=(~G1_L & !G2_L)?A:8'bz;
endmodule