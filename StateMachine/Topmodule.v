module Topmodule(
    input CLOCK,
    input A,B,
    output reg Z;
)
   parameter [2:0] INIT =3'b000,
                   A0=3'b001,
                   A1=3'b010,
                   OK0=3'b011,
                   OK1=3'b100;
   reg [2:0] Sreg , Snext;
   U1 NextState(
     .A(A),
     .B(B),
     .Snext(Snext)
   );
   U2 StateMemory(
     .Snext(Snext),
     .CLOCK(CLOCK),
     .Sreg(Sreg)
   );
   U3 OutputLogic(
     .Sreg(Sreg),
     ,Z(Z)
   );
 endmodule