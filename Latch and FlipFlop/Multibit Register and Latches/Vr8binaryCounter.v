// Ghép tầng từ 2 con Vr4binaryCounter 
module Vr8binaryCounter(
    input CLK , CLR ,
    input ENT1,ENP1, ENP2,
    input LD,
    input [7:0] D,
    output reg [7:0] Q,
    output RCO1 , RCO2
);
   Vr4binaryCounter counter1(
        .CLK(CLK),
        .CLR(CLR),
        .ENT(ENT1),
        .ENP(ENP1),
        .LD(LD),
        .D(D[3:0]),
        .Q(Q[3:0]),
        .RCO(RCO1)
    );
    Vr4binaryCounter counter2(
        .CLK(CLK),
        .CLR(CLR),
        .ENT(RCO1),
        .ENP(ENP2),
        .LD(LD),
        .D(D[7:4]),
        .Q(Q[7:4]),
        .RCO(RCO2)
    );
endmodule