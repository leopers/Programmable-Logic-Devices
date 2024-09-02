module AND (
    input a,
    input b,
    output y
);
    assign y = a & b;
endmodule 

module OR (
    input a,
    input b, 
    output y
);
    assign y = a | b;
endmodule

module XOR (
    input a,
    input b,
    output y
);
    assign y = a ^ b;
endmodule

module Full_Adder (
    input A,
    input B,
    input Cin,
    output S,
    output Cout
);
    wire w1, w2, w3;

    XOR U1 (.a(A), .b(B), .y(w1)); 
    XOR U2 (.a(w1), .b(Cin), .y(S));

    AND U3 (.a(A), .b(B), .y(w2));  
    AND U4 (.a(w1), .b(Cin), .y(w3)); 

    OR U5 (.a(w2), .b(w3), .y(Cout));  
endmodule