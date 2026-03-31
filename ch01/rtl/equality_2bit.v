module equality_2bit (
    input [1:0] a, b,
    output aeqb
);
  assign aeqb = (a==b);  
endmodule