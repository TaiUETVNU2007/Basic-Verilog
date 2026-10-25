// chuẩn chỉnh 
module Comparator(P,Q,PGTQ,PEQQ,PLTQ);
      input [7:0] P, Q ;
      output PQGTQ , PEQQ , PLTQ;
      assign PGTQ =((P>Q)?1'b1:1'b0);
      assign PEQQ =((P==Q)?1'b1:1'b0);
      assign PLTQ=~PGTQ &~PEQQ;
endmodule
      