module decoder_328_tb (
);
    reg [2:0] in;
    wire [7:0] code;
    integer i;
    
    decoder_328 dut (in, code);

    initial begin
        in = 3'b0;
        #10;
        $dumpfile("waves/decoder_328.vcd");
        $dumpvars(0,decoder_328_tb);
        
        $display("--- Starting Test ---");

        for(i=0;i<8;i=i+1) begin
            in = i[2:0]; 
            #10;
            $display("Test %0d: in[2]=%b, in[1]=%b, in[0]=%b | code=%b", i, in[2], in[1], in[0], code);

        end
        $finish;

    end
endmodule