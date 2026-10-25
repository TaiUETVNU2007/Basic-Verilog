`timescale 1 ns /100 ps
module VrNbitcmp();
    parameter N=64;
    parameter SEED=1;
    reg [N-1:0] P, Q;
    wire PGTQ1 , PGTQ2 , PLTQ1 , PLTQ2 ,PEQQ1, PEQQ2;
    integer ii , errors;
    task checkcmp;
        begin 
            if((PGTQ1!==PGTQ2) ||(PLTQ1!==PLTQ2) ||(PQEE1!==PQEE2)) begin
                errors =errors
                $display("P=%b(%0d), Q=%b(%0d), PGTQ1=%b, PEQQ1=%b, PLTQ1=%b, PGTQ2=%b, PEQQ2="%b", PLTQ2=%b", P, P, Q, Q,);
            end
        end
    endtask
    VrNbitcmp #(.N(N)) U1 ( .P(P), .Q(Q), .PGTQ(PGTQ1), .PEQQ(PEQQ1), .PLTQ(PLTQ1) );
    Vr64bitcmp UUT ( .P(P), .Q(Q), .PGTQ(PGTQ2), .PEQQ(PEQQ2), .PLTQ(PLTQ2) );
    initial begin
    errors = 0;
    P = $random(SEED); 
    for (ii=0; ii<10000; ii=ii+1) begin
        Q = P; #10 ; checkcmp; 
        P[31:0] = $random;
        if (N>32) P[63:32] = $random;
        if (N>64) P[95:64] = $random;
        if (N>96) P[127:96] = $random;
        #10 ;
        checkcmp; 
    end
    $display("Test done, %0d errors", errors);
    end
endmodule
