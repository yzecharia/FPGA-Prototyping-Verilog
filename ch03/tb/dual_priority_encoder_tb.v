module dual_priority_encoder_tb (
);
    reg [11:0] req;
    wire [3:0] first, second;
    wire first_valid, second_valid;

    dual_priority_encoder dut (req, first, second, first_valid, second_valid);

    reg [3:0] exp_first, exp_second;
    reg exp_first_valid, exp_second_valid;

    integer i ,j;
    integer errors;
    integer first_found, second_found;

    initial begin
        
        // Dump so I can get the signals
        $dumpfile("waves/dual_priority_encoder.vcd");
        $dumpvars(0, dual_priority_encoder_tb);

        errors = 0;

        $display("--- Starting Test ---");

        // Loop through all possible combinations of req
        for (i=0; i<4096; i=i+1) begin
            req = i[11:0];
            exp_first = 0;
            exp_second = 0;
            exp_first_valid = 0;
            exp_second_valid = 0;
            first_found = 0;
            second_found = 0;

            // Golden model to verifiy
            for (j=11; j >= 0; j=j-1) begin
                if (req[j] == 1'b1) begin
                    if (first_found == 0) begin
                        exp_first = j;
                        exp_first_valid = 1'b1;
                        first_found = 1;
                    end else if (second_found == 0) begin
                        exp_second = j;
                        exp_second_valid = 1'b1;
                        second_found = 1;
                    end
                end
            end

            // Let logic updat
            #10;

            // Verification
            if ((first_valid !== exp_first_valid) ||
                (second_valid !== exp_second_valid) ||
                (exp_first_valid && (first !== exp_first)) ||
                (exp_second_valid && (second !== exp_second))) begin
                $display("ERROR: req=%b, Expected: valid_first=%b, first=%0d | valid_second=%b, second=%0d", req, exp_first_valid, exp_first, exp_second_valid, exp_second);
                $display("GOT:                     valid_first=%b, first=%0d | valid_second=%b, second=%0d", first_valid, first, second_valid, second);
                errors = errors + 1;
            end 
        end

        // Summary
        $display("*******************************");
        if (errors == 0) $display("RESULT PASS");
        else $display("RESULT FAIL: %0d Errors", errors);
        $display("*******************************");

        $finish;


    end

endmodule