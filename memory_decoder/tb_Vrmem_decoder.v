module tb_Vrmem_decoder ();
    reg [39:30] Haddr;
    reg [2:0] Laddr;
    reg [1:0] size;
    wire [3:0] EN_L;
    wire [7:0] BE_L;
    reg [3:0] EN , ENMASK ;
    reg [7:0] BE , BEMASK ;
    reg [1:0] MADDR ;
    integer i , ahi , alo , sz errors ;
    parameter Byte = 2'b00, // Encoding for operation size
              Hword = 2'b01,
              Word = 2'b10,
              Lword = 2'b11;
    task displayerror begin
        errors = errors+1;
        $display("Error: HADDR=%10b, LADDR=%3b, SIZE=%2b, EN=%4b, BE=%8b",Haddr, Laddr, size, EN, BE);
    end
    endtask
Vrmem_decoder UTT (
    .Haddr(Haddr),
    .Laddr(Laddr),
    .size(size),
    .EN_L(EN_L),
    .BE_L(BE_L)
);
initial begin
    errors=0;
    for (ahi=0; ahi<1024; ahi=ahi+1) 
        for (alo=0; alo<8; alo=alo+1)
            for (sz=0; sz<4; sz=sz+1) begin
      // Các câu lệnh kiểm tra (UUT, if, displayerror,...)
                 Haddr=ahi;
                 Laddr=alo;
                 size=sz;
                 MADDR= HADDR[31:30] ;
                 #10 // cho 10ns để input vào ổn định mạch
                 EN= ~EN_L ;
                 BE= ~EN_L ;
                 ENMASK =~2(**(MADDR));
                 if (HADDR[39:32]!=8'b0) begin // Memory not enabled
                     if (EN!==4'b0000) displayerror;
                 end 
                 else begin
                    if ( (EN[MADDR] !== 1'b1) || ((EN & ENMASK)!==4'b0000) ) displayerror;
                    if (SIZE==BYTE) begin
                        BEMASK = ~(2**(LADDR)); // All 1s except selected byte's BE bit
                        if ( (BE[LADDR] !== 1'b1) || ((BE & BEMASK)!==8'h0)) displayerror;
                    end
                 end  
                 else if (size==Hword) 
                      case(Laddr)
                         3'b000: if (BE !== 8'b00000011) displayerror;
                         3'b010: if (BE !== 8'b00001100) displayerror;
                         3'b100: if (BE !== 8'b00110000) displayerror;
                         3'b110: if (BE !== 8'b11000000) displayerror;
                         default if (BE !== 8'b00000000) displayerror;
                      endcase
                  else if (size==Word)
                       case (Laddr)
                       3'b000: if (BE !== 8'b00001111) displayerror;
                       3'b100: if (BE !== 8'b11110000) displayerror;
                       default if (BE !== 8'b00000000) displayerror;
                       endcase
                  else // SIZE == LWORD
                      if ((Laddr==3'b000) && (BE !== 8'b11111111)) displayerror;
                      else if ((Laddr!=3'b000) && (BE !== 8'b00000000)) displayerror;
            end
end
endmodule
                          
