module dual_edge_detector (
    input in, clk, reset,
    output edge_detection
);

reg [1:0] state, next_state;
localparam a = 2'd0, b = 2'd1, c = 2'd2, d = 2'd3;

always @(posedge clk) begin
    if (reset) state <= a;
    else state <= next_state;
end

always @(*) begin
    case(state)
        a: next_state = in ? b : a;
        b: next_state = in ? c : d;
        c: next_state = in ? c : d;
        d: next_state = in ? b : a;
    endcase
end

assign edge_detection = (state == b || state == d);

    
endmodule