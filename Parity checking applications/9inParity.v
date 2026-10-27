module 9inParity(I, ODD);
      input [1:9] I;
      output reg ODD;
      integer i ;
      always @(*) begin
        ODD=1'b0;
        for(int i=1; i<=9 ; i=i+1) begin
            if (I[i]==1) ODD=~ODD;
        end
      end   
endmodule      