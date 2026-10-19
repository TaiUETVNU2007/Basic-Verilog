module Vr2in8mul_behavioral (
    input wire S , EN_l ,
    input wire [7:0] D0 , D1,
    ouput reg [7:0] Y
);
    always @(S or EN_l or D0 or D1) begin
        if(EN_L==1) Y=8'd0;
        else if (EN_L==0) begin
            case (S)
                1'b0: Y=D0;
                1'b1: Y=D1;
                default: Y=8'd0;
            endcase
        end
        else Y=8'd0;
    end 
endmodule    