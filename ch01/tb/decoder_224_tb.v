module decoder_224_tb (
);
    reg [1:0] in;
    reg en;
    wire [3:0] code;
    integer i;
    
    decoder_224 dut (en, in, code);

    initial begin
        en = 1'b0;
        in = 2'b0;
        #10;
        $dumpfile("waves/decoder_224.vcd");
        $dumpvars(0,decoder_224_tb);
        
        $display("--- Starting Test ---");

        for(i=0;i<8;i=i+1) begin
            {in, en} = i[2:0]; 
            #10;
            $display("Test %0d: in[1]=%b, in[0]=%b, en=%b | code=%b", i, in[1], in[0], en, code);

        end
        $finish;

    end
endmodule