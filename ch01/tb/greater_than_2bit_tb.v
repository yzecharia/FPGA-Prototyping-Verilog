`timescale 1ns / 1ps
module greater_than_2bit_tb (
);
    reg [1:0] a, b;
    wire agb;

    reg expected_agb;
    integer i, j;
    integer error_count;
    integer total_tests;

    greater_than_2bit dut (a, b, agb);

    initial begin
        $dumpfile("waves/greater_than_2bit.vcd"); 
        $dumpvars(0, greater_than_2bit_tb);
        $display("--- Starting Test (16 combinations) ---");
        error_count = 0;
        total_tests = 0;

        for (i=0; i<4; i=i+1) begin
            for(j=0; j<4; j=j+1) begin
                a = i[1:0]; b = j[1:0];
                expected_agb = (a > b);
                #10;
                total_tests = total_tests + 1;
                if (agb !== expected_agb) begin
                    $display("ERROR at %0t! a=%0d, b=%0d | Expected: %b, Got: %b", $time, a, b , expected_agb, agb);
                    error_count = error_count + 1;
                end else begin
                    $display("PASS: a=%0d, b=%0d | agb=%b", a, b, agb);
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