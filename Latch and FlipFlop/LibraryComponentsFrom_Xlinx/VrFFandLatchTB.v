`timescale 1 ns / 100 ps
module VrFFandLatchTB ();
reg Tclk, G1, G2, GE, CLR, PR, D1, D2;
wire Q1, Q2, Q3, Q4, Q5, Q6;
VrFFandLatches UUT ( .CLK(Tclk), .D1(D1), .D2(D2),
 .G1(G1), .G2(G2), .GE(GE), .CLR(CLR), .PR(PR),
 .Q({Q1,Q2,Q3,Q4,Q5,Q6}) ); // instantiate UUT
always begin // create free-running test clock with 20 ns period
 #0.2 Tclk = 1; #10; // 10 ns high (tiny offset for
 Tclk = 0; #9.8; // 10 ns low waveform readability)
end
always begin // Change D1 and D2 on a 15 ns cycle
 #2 D1 = ~D1; D2 = ~D2; // offset 2 ns from Tclk edges
 #5 D2 = ~D2;
 #5 D1 = ~D1; #3 ;
end
always begin // Change G1 every 20 ns and G2 every 30 ns,
 #4 G1 = ~G1; G2 = ~G2; // offset 4 ns
 #20 G1 = ~G1; #10 G2 = ~G2; #10 G1 = ~G1; #16 ;
end
always begin // Change GE every 60 ns, offset 2 ns
 #2 GE = ~GE; #58 ;
end
initial begin // Here's what to do starting at time 0
 CLR = 1; PR = 1; // Apply clear and preset
 D1 = 0; D2 = 1; // Initialize D inputs for desired waveform
 GE = 0; G1 = 0; G2 = 0; // Latches are initially closed
 #100 // Wait 100 ns for FPGA global reset
 #15 // Nothing should happen yet
 CLR = 0; PR = 0; // Now negate clear and preset
 #300 // Run another 300 ns
 $stop(1); // End test
end
endmodule