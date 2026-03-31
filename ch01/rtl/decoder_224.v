module decoder_224 (
    input en,
    input [1:0] in,
    output [3:0] code
);
    assign code[3] = en & in[1] & in[0];
    assign code[2] = en & in[1] & ~in[0];
    assign code[1] = en & ~in[1] & in[0];
    assign code[0] = en & ~in[1] & ~in[0];

endmodule