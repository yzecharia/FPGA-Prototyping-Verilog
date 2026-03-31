module pwm (
    input clk, reset,
    input [3:0] w, // D.C.
    output reg pwm_signal
);
    reg [3:0] count;

    always @(posedge clk) begin
        if (reset) count <= 4'd0;
        else begin
            count <= count + 4'd1;
            pwm_signal <= (count < w) ? 1'b1 : 1'b0;
        end
    end
endmodule