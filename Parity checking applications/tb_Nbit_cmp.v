` timescale 1ns / 100ps
module tb_Nbit_cmp();
    parameter N=8;
    parameter SEED=1;
    reg [N-1:0] P, Q;
    wire PGTQ , PEQQ , PLTQ ;
    integer ii , errors ;
    Vr8bitcmp UUT(
        .P(P),
        .Q(Q),
        .PGTQ(PGTQ),
        .PEQQ(PEQQ),
        .PLTQ(PLTQ)
    );
    initial begin
        errors =0 ;
        P = $random(SEED);
        for(ii=0;i<10000;ii=ii+1) begin
            P=$random(SEED);
            Q=$random(SEED);
            #10
        if((PGTQ!==(P>Q)) || (PLTQ!==(P<Q)) || (PEQQ!==(P==Q)));
            errors=errors+1;
            $display("P=%b(%0d), Q=%b(%0d), PGTQ=%b, PEQQ=%b, PLTQ=%b",P, P, Q, Q);
        end
        $display("Test done,%0d errors" , errors);
    end