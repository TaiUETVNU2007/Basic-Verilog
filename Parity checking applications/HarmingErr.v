module HarmingErr(DU,DC,NOERROR,EN);
       input  [1:7] DU ;
       output reg [1:7] DC;
       output reg NOERROR;
       integer i;
       function  [2:0] Syndrome;
            input [7:1] D;
            begin 
                Syndrome[0] = D[7] ^D[5] ^D[3] ^D[1];
                Syndrome[1] = D[2] ^D[6] ^ D[7] ^D[3];
                Syndrome[2] = D[7] ^ D[6] ^D[5] ^D[4];
            end
       endfunction
       always @(*) begin 
            DC=DU;
            i=Syndrome[DU];
            if(i=3'b000) NOERROR =1'b1;
            else begin
                NOERROR = 1'b0;
                DC[i] = ~DU[i];
            end
       end
endmodule                 