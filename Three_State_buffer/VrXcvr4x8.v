
// Được dùng trong điều khiển việc chuyển dự liệu của các hệ thống device cần dữ liệu của nhau như trong bộ SoC
module VrXcvr4x8(A,B,C,D, S, AOE_L, BOE_L, COE_L, DOE_L, MOE_L);
 input [2:0] S;
 input AOE_L, BOE_L, COE_L, DOE_L, MOE_L;
 inout [1:8] A, B, C, D;
 reg [1:8] ibus;
 always @ (A or B or C or D or S) begin
 if (S[2] == 0) ibus = {4{S[1:0]}};
 else case (S[1:0])
 2’b00: ibus = A;
 2’b01: ibus = B;
 2’b10: ibus = C;
 2’b11: ibus = D;
 endcase
 end
 assign A = ((~AOE_L & ~MOE_L) && (S[2:0]!=3'b100)) ? ibus:8'bz;
 assign B = ((~BOE_L & ~MOE_L) && (S[2:0]!=3'b101)) ? ibus:8'bz;
 assign C = ((~COE_L & ~MOE_L) && (S[2:0]!=3'b110)) ? ibus:8'bz;
 assign D = ((~DOE_L & ~MOE_L) && (S[2:0]!=3'b111)) ? ibus:8'bz;
endmodule