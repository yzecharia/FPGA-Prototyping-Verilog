module greater_than (
    input [3:0] a, b,
    output a_greater_b
);

    wire upper, upper_eq, lower;

    greater_than_2bit uut0 (a[3:2], b[3:2], upper);
    equality_2bit uut1 (a[3:2], b[3:2], upper_eq);
    greater_than_2bit uut2 (a[1:0], b[1:0], lower);

    assign a_greater_b = upper | upper_eq & lower;

endmodule

