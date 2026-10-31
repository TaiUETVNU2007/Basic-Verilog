module OutputLogic (
    input [2:0] Sreg,
    output reg z
);
  always @(Sreg) begin
      case(Sreg)
        INIT,A0,A1: Z=0;
        OK0,OK1: Z=1;
        default: Z=0;
      endcase
  end