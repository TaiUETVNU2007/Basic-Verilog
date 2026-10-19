module Checkprime(
    input [3:0] N;
    output reg is_prime;
    parameter One = 1;
)
    always @(*) begin
        if (N <=1) is_prime=0;
        else if (N%2==0) 
            begin 
                if (N==2) is_prime=1;
                else is_prime=0;
            end
        else if (N<=7) is_prime=1;
        else if ((N==11)|| (N==13)) is_prime=1;
        else is_prime=0;
    end
endmodule                