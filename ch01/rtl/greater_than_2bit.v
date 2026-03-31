module greater_than_2bit (
    input [1:0] a,b,
    output agb
);
    assign agb = (a[1] & ~b[1]) | ((a[0] & ~b[0]) & (~(a[1] ^ b[1])));
endmodule