module Comparison(
    input [7:0] A,B;
    output reg [7:0] data_out;
)
    reg gt;
    integer i;
    always @(*) begin : comparison_loop
        for(i=7 ; i>=0 ; i--) begin 
            if (A[i] & ~B[i]) begin
                gt=1;
                disable comparison_loop;
            end    
            else if (~A[i] & B[i]) begin
                gt=0;
                disable comparison_loop;
            end  
        end      
    end
    assign data_out = gt ? A : B;
endmodule        

            