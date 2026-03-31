

module square_wave_generator (
    input [3:0] m, n,
    input clk, reset,
    output reg square_wave
);

/*
    T_clock = 20[ns];
    T_on = m = m * 100 [ns] == m * 5* T_clock;
    T_off = n = n * 100 [ns] == n * 5 * T_clock;
*/

reg [3:0] state_count;
reg [2:0] count_100;

wire tick_100 = (count_100 == 3'd4);

// always block for count_100;
always @(posedge clk) begin
    if (reset) count_100 <= 3'd0;
    else if (tick_100) count_100 <= 3'd0;
    else count_100 <= count_100 + 3'd1;
end

//2 states On and OFF: {1'b1: m (ON), 1'b0: n (OFF)}
reg state;

always @(posedge clk) begin
    if (reset) begin
        state <= 1'b0;
        state_count <= 4'd0;
        square_wave <= 1'b0;
    end else if (tick_100) begin
        if (state == 1'b0) begin
            if (state_count >= n - 1'b1) begin
                state_count <= state_count + 1;
            end else begin
                state_count <= 4'd0;
                state <= 1'b1;
            end
        end else begin
            if (state_count >= m - 1'b1) begin
                state_count <= state_count + 1;
            end else begin
                state_count <= 4'd0;
                state <= 1'b0;
            end
        end
    end
    square_wave = state;
end
    
endmodule
