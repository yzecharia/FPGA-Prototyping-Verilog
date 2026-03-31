module parking_lot_occupancy (
    input a, b, 
    input clk, reset,
    output enter, exit
);

    /* This solution isnt the FSM I will do this on pure logic */

    reg a_reg;

    always @(posedge clk) begin
        if (reset) a_reg <= 1'b0;
        else a_reg <= a;
    end 

    assign enter = ~(a_reg ^ b);
    assign exit = (a_reg ^ b);
    
endmodule

/* This part will be the full fsm */
// I made the fsm moore, can do mealy and get only 7 states.
module parking_lot_fsm (
    input a, b , clk, reset, 
    output enter, exit
);

    reg [3:0] state, next_state;
    localparam a=4'd0, b=4'd1, c=4'd2, d=4'd3, e=4'd4, f=4'd5, g=4'd6, h=4'd7, i=4'd8;

    wire [1:0] ab = {a,b};

    always @(posedge clk) begin
        if (reset) state <= a;
        else state <= next_state;
    end

    always @(*) begin
        case(state) 
            a: begin
                if (ab == 2'b00) next_state = a;
                else if (ab == 2'b01) next_state = f;
                else if (ab == 2'b10) next_state = b;
            end
            b: begin
                if (ab ==2'b00) next_state = a;
                else if (ab == 2'b10) next_state = b;
                else if (ab == 2'b11) next_state =c;
            end
            c: begin
                if (ab == 2'b01) next_state = d;
                else if (ab == 2'b11) next_state = c;
                else if (ab == 2'b10) next_state = b;
            end
            d: begin
                if (ab == 2'b01) next_state = d;
                else if (ab == 2'b11) next_state = c;
                else if (ab == 2'b00) next_state = e;
            end
            e: begin
                next_state = a;
            end
            f: begin 
                if (ab == 2'b00) next_state = a;
                else if (ab == 2'b01) next_state = f;
                else if (ab == 2'b11) next_state = g;
            end
            g: begin
                if (ab == 2'b11) next_state = g;
                else if (ab == 2'b01) next_state = f;
                else if (ab == 2'b10) next_state = h;
            end
            h: begin
                if (ab == 2'b10) next_state = h;
                else if (ab == 2'b00) next_state = i;
                else if (ab == 2'b10) next_state = h;
            end
            i: next_state = a;
            default: next_state = state;
        endcase
    end

    assign entry = (state == e);
    assign exit = (state == i);
endmodule