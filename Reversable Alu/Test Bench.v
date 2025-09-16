`timescale 1ns / 1ps

module alu_db_tb;

    // Inputs
    reg A, B, C, D;
    reg S0, S1;
    reg clk;
    reg [1:0] M1, M2;

    // Outputs
    wire Sum, Carry, Diff, Bout, Storing, Mux_out;
    wire AND_out, OR_out, NOT_out, XOR_out, XNOR_out, NAND_out, NOR_out;
    wire [3:0] Product;
    wire [3:0] Decoder_Y;

    // Instantiate the Unit Under Test (UUT)
    alu_db uut (
        .A(A), .B(B), .C(C), .D(D),
        .S0(S0), .S1(S1), .M1(M1), .M2(M2), .clk(clk),
        .Sum(Sum), .Carry(Carry), .Diff(Diff), .Bout(Bout),
        .Product(Product), .Storing(Storing), .Mux_out(Mux_out),
        .Decoder_Y(Decoder_Y),
        .AND(AND_out), .OR(OR_out), .NOT(NOT_out),
        .XOR(XOR_out), .XNOR(XNOR_out), .NAND(NAND_out), .NOR(NOR_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        A = 0; B = 0; C = 0; D = 0;
        S0 = 0; S1 = 0;
        M1 = 2'b00; M2 = 2'b00;

        // Apply test vectors
        #10 A=1; B=0; C=1; D=0; // basic input set
        #10 A=1; B=1; C=0; D=1;
        #10 A=0; B=1; C=1; D=1;

        // Test multiplier
        #10 M1=2'b01; M2=2'b10; 
        #10 M1=2'b11; M2=2'b11; 

        // Test mux
        #10 S0=0; S1=0;
        #10 S0=1; S1=0;
        #10 S0=0; S1=1;
        #10 S0=1; S1=1;

        // Test subtractor
        #10 A=1; B=0; C=0;
        #10 A=1; B=1; C=0;
        #10 A=0; B=1; C=1;

        // Test storing element (simulate D flip-flop style)
        #10 D=1;
        #10 D=0;

        // Finish simulation
        #50 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("T=%0t | A=%b B=%b C=%b D=%b | Sum=%b Carry=%b Diff=%b Bout=%b | AND=%b OR=%b NOT=%b XOR=%b XNOR=%b NAND=%b NOR=%b | Product=%b | Mux_out=%b | Decoder_Y=%b | Storing=%b",
                  $time, A,B,C,D, Sum,Carry,Diff,Bout,
                  AND_out,OR_out,NOT_out,XOR_out,XNOR_out,NAND_out,NOR_out,
                  Product, Mux_out, Decoder_Y, Storing);
    end

endmodule
