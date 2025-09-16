`timescale 1ns / 1ps

module alu_db(
    A,B,C,D,S0,S1,M1,M2,clk,
    Sum,Carry,Diff,Bout,Product,Storing,
    Mux_out,Decoder_Y,AND,OR,NOT,XOR,XNOR,NAND,NOR
);
input A,B,C,D,S0,S1,clk;
input [1:0]M1,M2;
output Sum,Carry,Diff,Bout,Storing,Mux_out,AND,OR,NOT,NAND,NOR,XOR,XNOR;
output [3:0]Product;
output [3:0]Decoder_Y;

Full_adder x1(A,B,C,Sum,Carry);
Multiplexer4to1 x2(A,B,C,D,S1,S0,Mux_out);
Multiplier2bit x3(M1,M2,Product);
Storing_element x4(clk,D,Storing);
Subtractor x5(A,B,C,Diff,Bout);
Decoder2to4 x6(A,B,Decoder_Y);

// Direct logical operations
assign AND  = A & B;
assign OR   = A | B;
assign NOT  = !A;
assign XOR  = A ^ B;
assign XNOR = !(A ^ B);
assign NOR  = !(A | B);
assign NAND = !(A & B);

endmodule


// ------------------- Supporting Modules -------------------
module Full_adder(A,B,Cin,Sum,Carry);
input A,B,Cin;
output Sum,Carry;
peres p1(A,B,0,p,q,r);
peres p2(q,Cin,r,G,Sum,Carry);
endmodule


module Multiplexer4to1(I0,I1,I2,I3,S1,S0,OUT);
input I0,I1,I2,I3,S0,S1;
output OUT;
MF m1(S0,I1,I0,a,G1,b);
MF m2(S0,I3,I2,c,G2,d);
MF m3(S1,d,b,e,G3,OUT);
endmodule

module Multiplier2bit(
    input [1:0] M1,M2,
    output [3:0] P
    );
peres o1(M1[0],M2[0],0,p1,q1,pp1);
peres o2(M1[0],M2[1],0,p2,q2,pp2);
peres o3(M1[1],M2[0],0,p3,q3,pp3);
peres o4(M1[1],M2[1],0,p4,q4,pp4);
assign P[0]=pp1;
Half_adder_db o5(pp2,pp3,P[1],c);
Half_adder_db o6(c,pp4,P[2],P[3]);
endmodule

module Half_adder_db(
    input A,B,
    output S,Cout
    );
Toffoli t1(A,B,0,p,q,Cout);
cnot t2(p,q,c,S);
endmodule

module Storing_element(
    input clkin,D,
    output OUT
    );
fredkin f1(clkin,D,f,P,Q,OUT);
assign f=OUT;
endmodule

module fredkin(A,B,C,p,q,r);
input A,B,C;
output p,q,r;
assign p=A;
assign q=(!A&B)^(A&C);
assign r=(A&B)^(!A&C);
endmodule

module Subtractor(A,B,Bin,diff,Bout);
    input A,B,Bin;
    output diff,Bout; 
DKG d1(1,A,B,Bin,p,q,Bout,diff);
endmodule

module DKG(A,B,C,D,P,Q,R,S);
input A,B,C,D;
output P,Q,R,S;
assign P=B;
assign Q=A^C;
assign R=((A^B)&(C^D))^(C&D);
assign S=B^C^D;
endmodule

module Decoder2to4(
    input I0,I1,
    output [3:0]Y
    );
peres h1(I1,I0,0,g1,p1,p2);
TR h2(I1,I0,0,g2,t1,t2);
cnot h3(p2,0,c1,Y[3]);
cnot h4(!p1,c1,g3,Y[0]);
cnot h5(t2,t1,Y[2],Y[1]);
endmodule

module cnot(A,B,p,q);
input A,B;
output p,q;
assign p=A;
assign q=A^B;
endmodule

module TR(A,B,C,p,q,r);
input A,B,C;
output p,q,r;
assign p=A;
assign q=A^B;
assign r=(A&!B)^C;
endmodule

module MF(S,B,A,O,G0,Y);
input S,A,B;
output O,G0,Y;
assign O=S;
assign G0=(!S&B)|(S&A);
assign Y=(!S&A)|(S&B);
endmodule

module FG(A,B,O,Y);
input A,B;
output O,Y;
assign O=A;
assign Y=A^B;
endmodule

module Toffoli(A,B,C,p,q,r);
input A,B,C;
output p,q,r;
assign p=A;
assign q=B;
assign r=(A&B)^C;
endmodule

module peres(A,B,C,p,q,r);
input A,B,C;
output p,q,r;
assign p=A;
assign q=A^B;
assign r=(A&B)^C;
endmodule
