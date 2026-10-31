module 5to32_decoder(
    input wire [1:0] EN1;
    input wire [1:0] EN2;
    input wire [4:0] data_in;
    output reg [31:0] data_out
)
   reg [3:0] data_control;
   3to8_decoder U0(
       .Enable(EN1),
       .G2B(0),
       .data_in({data_in[4:3],1b'0}),
       .data_out(data_control),
   );
   3to8_decoder U1(
      .Enable(EN2),
      .G2B(0),
      .data_in(data_in[2:0]),
      .data_out(data_out[31:24]),
   )
   3to8_decoder U1(
    .Enable(EN2),
    .G2B(0),
    .data_in(data_in[2:0]),
    .data_out(data_out[23:16]),
   )
   3to8_decoder U1(
    .Enable(EN2),
    .G2B(0),
    .data_in(data_in[2:0]),
    .data_out(data_out[15:8]),
   )
   3to8_decoder U1(
    .Enable(EN2),
    .G2B(0),
    .data_in(data_in[2:0]),
    .data_out(data_out[7:0]),
   )
endmodule  