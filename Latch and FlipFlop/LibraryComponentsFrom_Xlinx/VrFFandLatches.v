module VrFFandLatches (
    input CLK,G1 , G2 ,GE, CLR,PR,
    input [1:4] D,
    output [1:6] Q
);
    LDCE U1(
        .G(G1),
        .GE(GE),
        .D(D[1]),
        .CLR(CLR),
        .Q(Q[1])
    );
    LDPE U2(
        .G(G2),
        .GE(1'b1),
        .D(D[2]),
        .PRE(PR),
        .Q(Q[2])
    );
    FDCE U3(
        .C(CLK),
        .D(D[1]),
        .CLR(CLR),
        .Q(Q[3]),
        .CE(GE)
    );
    FDPE U4(
        .C(CLK),
        .D(D[2]),
        .PRE(PR),
        .Q(Q[4]),
        .CE(GE)
    );
    FDRE U5(
        .C(CLK),
        .D(D[3]),
        .R(CLR),
        .Q(Q[5]),
        .CE(1'b1)
    );
    FDSE U6(
        .C(CLK),
        .D(D[4]),
        .S(PR),
        .Q(Q[6]),
        .CE(GE)
    );
endmodule

