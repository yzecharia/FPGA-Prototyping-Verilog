module decoder_328 (
    input [2:0] in,
    output [7:0] code
);
    wire [3:0] upper, lower;
    decoder_224 uut0 (in[2], in[1:0], upper);
    decoder_224 uut1 (~in[2], in[1:0], lower);

    assign code = {upper, lower};
    
endmodule