`timescale 1ns / 1ps
module greater_than_tb (
);

    reg [3:0] a, b;
    wire a_greater_b;

    greater_than dut (a, b, a_greater_b);

    integer i, j;
    reg expected;
    integer error_count;
    integer total_tests;

    initial begin
        $dumpfile("waves/greater_than.vcd");
        $dumpvars(0, greater_than_tb);

        $display("Starting Test:");
        error_count = 0;
        total_tests = 0;

        for (i=0; i<16; i=i+1) begin
            for (j=0;j<16; j=j+1) begin
                a = i[3:0]; b = j[3:0];
                expected = (a > b);
                #10;
                total_tests = total_tests + 1;
                if (a_greater_b !== expected) begin
                    $display("ERROR at %0t! a=%0d, b=%0d | Expected=%b, Got=%b", $time, a, b, expected, a_greater_b);
                    error_count = error_count + 1;
                end else begin
                    $display("PASS: a=%0d, b=%0d | a_greater_b=%b", a, b, a_greater_b);
                end
            end
        end

        $display("\n========================================");
        $display("TEST SUMMARY:");
        $display("Total Combinations Tested: %0d", total_tests);
        
        if (error_count == 0) begin
            $display("RESULT: PERFECT PASS! (0 Errors)");
        end else begin
            $display("RESULT: FAILED! (%0d Errors found)", error_count);
        end
        $display("========================================\n");
        
        $finish;

    end
    
endmodule