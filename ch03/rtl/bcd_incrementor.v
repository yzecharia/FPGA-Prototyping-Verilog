module bcd_incrementor (
    input [11:0] num_in,
    output [11:0] bcd,
    output overflow
);
    
    wire en1, en2;

    bcd_inc_4bit uut0 (1'b1, num_in[3:0], bcd[3:0], en1);
    bcd_inc_4bit uut1 (en1, num_in[7:4], bcd[7:4], en2);
    bcd_inc_4bit uut2 (en2, num_in[11:8], bcd[11:8], overflow);


endmodule

module bcd_inc_4bit (
    input en,
    input [3:0] num,
    output reg [3:0] num_inc,
    output en_next
);
    always @(*) begin
        if (en) begin
            if (num == 4'd9) num_inc = 4'd0;
            else num_inc = num + 1;
        end else num_inc = num;
    end
    assign en_next = (en && num == 4'd9);
endmodule