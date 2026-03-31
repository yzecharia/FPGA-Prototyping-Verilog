module floating_point_greater (
    input [12:0] a, b,
    output agtb
);

    wire sign_a = a[12], sign_b = b[12];
    wire [11:0] mag_a = a[11:0], mag_b = b[11:0];

    assign agtb = (~sign_a & sign_b) ? 1'b1 : // a positive b negetive
                  (sign_a & ~sign_b) ? 1'b0 : // a negative b positive
                  (sign_a) ? (mag_a < mag_b) : // both negative
                             (mag_a > mag_b); // both positive  
    
endmodule