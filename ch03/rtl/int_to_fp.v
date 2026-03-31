module int_to_fp (
    input [7:0] int_in,
    output [12:0] fp_out
);

    wire sign = int_in[7];
    wire [6:0] abs_val = sign ? -int_in[6:0] : int_in[6:0];
    wire [2:0] leading_one_index;
    wire valid;

    prio_encoder_723 uut0 (abs_val, leading_one_index, valid);

    wire [7:0] mantissa = valid ? (abs_val << (7 - leading_one_index)) : 8'd0;
    wire [3:0] exp = valid ? (4'd8 + leading_one_index) : 4'd0;

    assign fp_out = {sign, exp, mantissa};
    
endmodule

module prio_encoder_723 (
    input [6:0] val,
    output reg [2:0] index,
    output valid
);

    always @(*) begin
        casez(val) 
            7'b1??????: index = 3'd6;
            7'b01?????: index = 3'd5;
            7'b001????: index = 3'd4;
            7'b0001???: index = 3'd3;
            7'b00001??: index = 3'd2;
            7'b000001?: index = 3'd1;
            7'b0000001: index = 3'd0;
        endcase
    end 
    assign valid = |val;
endmodule