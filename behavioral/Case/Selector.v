module Selector(
    input [1:0] sel;
    input [3:0] A, B , C;
    output reg [3:0] data_out ;
)
   
    always @(*) begin
        case(sel)
            2'b00: data_out = A;
            2'b01: data_out = B;
            2'b10: data_out = C;
            default: data_out = 4'b0000;
        endcase
    end
endmodule        
            