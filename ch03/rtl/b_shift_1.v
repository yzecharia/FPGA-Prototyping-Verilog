module b_shift_1 (
    input lr,
    input [7:0] data,
    output [7:0] shifted_data
);
    wire [7:0] left_shift, right_shift;
    left_shift_1 uut0 (data, left_shift);
    right_shift_1 uut1 (data, right_shift);

    assign shifted_data = lr ? left_shift : right_shift;
endmodule

module left_shift_1 (
    input [7:0] data,
    output [7:0] shifted_data
);

    assign shifted_data = {data[6:0], data[7]};

endmodule

module right_shift_1 (
    input [7:0] data,
    output [7:0] shifted_data
);

    assign shifted_data = {data[0], data[7:1]};
    
endmodule