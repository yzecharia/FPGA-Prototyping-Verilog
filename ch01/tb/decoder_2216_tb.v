module decoder_2216_tb (
);
    reg [3:0] in;
    wire [15:0] code;
    integer i;
    
    decoder_2216 dut (in, code);

    initial begin
        in = 4'b0;
        #10;
        $dumpfile("waves/decoder_2216.vcd");
        $dumpvars(0,decoder_2216_tb);
        
        $display("--- Starting Test ---");

        for(i=0;i<16;i=i+1) begin
            in = i[3:0]; 
            #10;
            $display("Test %0d: in[3]=%b, in[2]=%b, in[1]=%b, in[0]=%b | code=%b", i, in[3], in[2], in[1], in[0], code);

        end
        $finish;

    end
endmodule