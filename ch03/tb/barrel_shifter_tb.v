module barrel_shifter_tb (
);
    
    localparam N = 8;

    reg [N-1:0] data;
    reg [$clog2(N) - 1:0] amt;
    reg lr;
    wire [N-1:0] shifted_data;

    reg[N-1:0] expected;
    integer i, j;
    integer errors;

    barrel_shifter #(.N(N)) dut (lr, amt, data, shifted_data);

    initial begin
        
        // Dump so I can get the signals
        $dumpfile("waves/barrel_shifter.vcd");
        $dumpvars(0, barrel_shifter_tb);

        // Initialize 
        data = 8'b10110001;
        errors = 0;
        
        //Start test
        $display("--- Statrting Test  (N=%0d) ---", N);
        $display("Input data: %b", data);
        
        for (i=0; i<2; i=i+1) begin //Loop for lr
            lr = i;

            for (j=0; j<N; j=j+1) begin // Loop for amt (Check all shifting amounts)
                amt = j;
                // Calculate expected values
                if (lr == 0) expected = (data >> amt) | (data << (N-amt)); // Right shit
                else expected = (data << amt) | (data >> (N-amt)); // Left shift

                #10;

                // Check Values after giving time for logic to change
                if (shifted_data !== expected) begin
                    $display("ERROR: lr=%b, amt=%0d, data=%b | Expected: %b, Got: %b", lr, amt, data, expected, shifted_data);
                    errors = errors + 1;
                end else begin
                    $display("PASS: lr=%b, amt=%0d, data=%b | shifted_data=%b", lr, amt, data, shifted_data);
                end
            end 

        end

        // Summary of test results:
        $display("********************************");
        if (errors == 0) $display("RESULT: Test PASS (0 Errors)");
        else $display("RESULT: Test FAIL (%0d Errors)", errors);
        $display("********************************");

        $finish;

    end

endmodule