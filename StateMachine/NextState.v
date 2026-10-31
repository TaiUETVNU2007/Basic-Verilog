module NextState (
    input A,B,
    output reg [2:0] Snext,
    input [2:0] Sreg
);
  reg [2:0] Sregg=Sreg;
  always @(A,B,Sregg) begin
     case(Sregg)
       INIT: if (A==0) Snext=A0;
             else      Snext=A1;
       A0: if(A==0) Snext=OK0;
           else     Snext=A1;
       A1: if(A==0) Snext=A0;
           else     Snext=OK1;
       OK0: if(A==0) Snext=OK0;
            else if({A,B}==2'b11) Snext=OK1;
            else  Snext=A1;
       OK1: if({A,B}==2'b00) Snext=A0;
            else if ({A,B}==2'b00) Snext=OK0;
            else Snext=OK1;
       default : Snext=1'b0;
     endcase      
  end
endmodule