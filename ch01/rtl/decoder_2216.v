module decoder_2216 (
    input [3:0] in,
    output [15:0] code
);
    wire [3:0] en, dec0, dec1, dec2, dec3;

    decoder_224 uut0 (1'b1, in[3:2], en);
    decoder_224 uut1 (en[0], in[1:0], dec0);
    decoder_224 uut2 (en[1], in[1:0], dec1);
    decoder_224 uut3 (en[2], in[1:0], dec2);
    decoder_224 uut4 (en[3], in[1:0], dec3);

    assign code = {dec3,dec2,dec1,dec0};


endmodule