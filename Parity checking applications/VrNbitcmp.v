module VrNbitcmp(P,Q,PGTQ,PLTQ,PEQQ);
       parameter N=8;
       input [N-1,0] P,Q;
       output PGTQ , PEQQ , PLTQ;
       assign PGTQ=((P>Q)?1'b1:1'b0);
       assign PEQQ=((P==Q)?1'b1:1'b0);
       assign PLTQ=~PGTQ &~PEQQ;
endmodule