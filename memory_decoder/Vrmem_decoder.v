module Vrmem_decoder (
    input wire [39:30] Haddr,// high address
    input wire [2:0] Laddr,// low address
    input wire [1:0] size ,
    output reg [3:0] EN_L,// đây là cấp quyền cho thanh mem nào đc sử dụng
    output reg [7:0] BE_L  // đây là dây cấp quyền cho byte nào được nhả cả bit 
);
reg EN_MEM ;
reg [3:0] EN ;
reg [7:0] BE;
integer i;
parameter Byte =2'b00,
          Hword=2'b01 ,
          Word = 2'b10,
          Lword 2'b11;
always @(*) begin
    EN = 4'b0000;
    BE= 8'b00000000;
    EN_MEM = (Haddr[39:32]==8'0000000);// điều kiện enable memory
    if (EN_MEM) begin
        for(i-0;i<=3;i++) 
            if (Haddr[31:30]==i) EN[i]=1'b1;// chọn module memory (1 trong 4)
        // bắt đầu xử lí chọn byte   
        if (size==Lword) BE=8'b11111111;
        else if(size==Word) begin
            if (Laddr==3'b000) BE=8'h0F;
            else if (Laddr=3'b100) BE=8'hF0;
        end
        else if(size==Hword) begin 
            case(Laddr)
               3'b000: BE=8'b00000011;
               3'b010: BE=8'b00001100;
               3'b100: BE=8'b00110000;
               3'b110: BE=8'b11000000;
               default:BE=8'b00000000;
            endcase
        end
        else //byte
          for (i=0;i<=7;i++) 
              if(Laddr ==i) BE[i]=1'b1;          
    end
end
// Đảo lại chân theo module.
assign EN_L =~EN ;
assign BE_L=~BE;
endmodule

