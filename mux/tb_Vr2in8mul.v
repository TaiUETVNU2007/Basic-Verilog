`timescale 1ns/100ps
module tb_Vr2in8mul ();
reg S0 , EN_L0 ;
reg [7:0] D0 , D1 ;
reg [7:0] Y0;
integer i , errors ;
task displayError begin
    errors =errors +1 ;
    $display("Errors:EN_L=%b , S=%b,D0=%b, D1=&b, Y=%b", EN_L0 , D0 , D1 , Y0);
end
endtask
Vr2in8mul_behaviral UUT(
    .S(S0),
    .EN_L(~EN_L0),
    .D0(D0),
    .D1(D1),
    .Y0(Y0)
);
initial begin
    errors=0;
    for(i=0; i<2500;i=i+1) begin
        EN_L0=0; S0=0;#10;
        if (Y!==0) displayError ;
        S0=1;#10;
        if (Y!==0) displayError ;
        EN_L0 =1 ; D0=$random %256 ; D1=$random %256 ;
        S=0 ; #10 ;
        if (Y!==D0) displayError ;
        S=1 ; #10;
        if (Y!==D1)  displayError ;
    end
    &display("Test done, %d errors" , errors);
end
endmodule
