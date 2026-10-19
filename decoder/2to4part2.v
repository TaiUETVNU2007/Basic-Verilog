module decoder_2to4part2(
    input A0 , A1 , EN,
    output reg Y0 , Y1 , Y2 , Y3
);
always @(A0 or A1 or EN) begin
    if (EN==1) {Y3,Y2,Y1,Y0}=4'b0000;
    else begin
        case({A1, A0})
          2'b00:{Y3 , Y2 , Y1 , Y0}=4'b0001;
          2'b01:{Y3 , Y2, Y1 , Y0}=4'b0010;
          2'b10:{Y3 , Y2, Y1 , Y0}=4'b0100;
          2'b11:{Y3 , Y2, Y1 , Y0}=4'b1000;
          default:{Y3 , Y2, Y1 , Y0}=4'b0000;
        endcase  
    end
end
endmodule