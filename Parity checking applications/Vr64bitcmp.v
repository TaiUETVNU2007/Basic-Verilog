module Vr64bitcmp(P,Q,PGTQ,PEQQ,PLTQ);
      input [63:0] P, Q;
      output PGTQ,PEQQ,PLTQ;
      wire [7:0] GT,EQ,LT; 
      VrNbitcmp U1(P[7:0],Q[7:0],GT[0],EQ[0],LT[0]);
      VrNbitcmp U2(P[15:8],Q[15:8],GT[1],EQ[1],LT[1]);
      VrNbitcmp U3(P[23:16],Q[23:16],GT[2],EQ[2],LT[2]);
      VrNbitcmp U4([31:24],Q[31:24],GT[3],EQ[3],LT[3]);
      VrNbitcmp U6(P[39:32],Q[39:32],GT[4],EQ[4],LT[4]);
      VrNbitcmp U7(P[47:40],Q[47:40],GT[5],EQ[5],LT[5]);
      VrNbitcmp U8(P[55:48],Q[55:48],GT[6],EQ[6],LT[6]);
      VrNbitcmp U9(P[63:56],Q[63:56],GT[7],EQ[7],LT[7]);
endmodule      
      