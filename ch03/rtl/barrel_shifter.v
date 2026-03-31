module barrel_shifter #(
    parameter N = 8
) (
    input lr,
    input [$clog2(N) - 1 : 0] amt,
    input [N-1 : 0] data,
    output [N-1:0] shifted_data
);

    function [N-1:0] reverse(input [N-1:0] in);
        integer i;
        begin
            for (i=0; i<N; i=i+1) begin
                reverse[i] = in[N-1-i];
            end
        end
    endfunction


    wire [N-1:0] is_rev =  lr ? reverse(data) : data;
    wire [N-1:0] shifted = (is_rev >> amt) | (is_rev << (N - amt));
    assign shifted_data = lr ? reverse(shifted) : shifted;
    
endmodule