// D Flipflop 
module StateMemory(
    input [2:0] Snext,
    ouput reg [2:0] Sreg,
    input CLOCK
);
  always @(posedge CLOCK) begin
    Sreg<=Snext;
  end
endmodule