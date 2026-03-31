module bcd_incrementor_tb ();
    reg [11:0] num_in;
    wire [11:0] bcd;
    wire overflow;

    bcd_incrementor dut (num_in, bcd, overflow);

    integer i, j, k;
    reg [11:0] exp_bcd;
    reg exp_overflow;
    integer errors;

    initial begin
        $dumpfile("waves/bcd_incrementor.vcd");
        $dumpvars(0, bcd_incrementor_tb);

        errors = 0;

        $display("--- Starting Test ---");

        for(i=0; i<10; i=i+1) begin
            for(j=0; j<10; j=j+1) begin
                for(k=0; k<10; k=k+1) begin
                    num_in = {i[3:0], j[3:0], k[3:0]};

                    // GOLDEN MODEL
                    if (k == 9) begin
                        if (j == 9) begin
                            if (i == 9) begin
                                exp_bcd = 12'd0;
                                exp_overflow = 1'b1;
                            end else begin
                                exp_bcd = {(i[3:0] + 4'd1), 4'h0, 4'h0}; 
                                exp_overflow = 1'b0;
                            end
                        end else begin
                            exp_bcd = {i[3:0], (j[3:0] + 4'd1), 4'h0}; 
                            exp_overflow = 1'b0;
                        end
                    end else begin
                        exp_bcd = {i[3:0], j[3:0], (k[3:0] + 4'd1)}; 
                        exp_overflow = 1'b0;
                    end

                    #10; // Let combinational logic update
                    
                    // VERIFICATION
                    if (bcd !== exp_bcd || overflow !== exp_overflow) begin
                        $display("ERROR: num_in=%x| exp_bcd=%x, exp_overflow=%b | GOT: bcd=%x, overflow=%b", 
                                  num_in, exp_bcd, exp_overflow, bcd, overflow);
                        errors = errors + 1;
                    end 
                end
            end
        end

        // Test summary
        $display("========================================");
        if (errors == 0) $display("TEST PASS");
        else $display("TEST FAIL (%0d Errors)", errors);
        $display("========================================");

        $stop;

    end

endmodule