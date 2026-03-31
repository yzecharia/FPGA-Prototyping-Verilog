module dual_priority_encoder (
    input [11:0] req,
    output [$clog2(12)-1:0] first, second,
    output first_valid, second_valid
);
    // Find the first one index
    priority_encoder uut0 (req, first, first_valid);

    // Create a mask if valid
    wire [11:0] mask = first_valid ? (12'b1 << first) : 12'b0;

    // Remove the first one using the mask
    wire [11:0] dup_req = mask ^ req;

    // find second 1 index
    priority_encoder uut1 (dup_req, second, second_valid);
endmodule

module priority_encoder (
    input [11:0] data,
    output [$clog2(12) - 1:0] index,
    output valid
);

    wire [2:0] valids;
    wire [1:0] indexes [2:0];

    prio_422 uut0 (data[3:0], indexes[0], valids[0]);
    prio_422 uut1 (data[7:4], indexes[1], valids[1]);
    prio_422 uut2 (data[11:8], indexes[2], valids[2]);

    assign valid = |valids;
    assign index = (valids[2]) ? {2'd2, indexes[2]} : (valids[1]) ? {2'd1, indexes[1]} : (valids[0]) ? {2'd0, indexes[0]} : 4'd0; 



endmodule

module prio_422 (
    input[3:0] data,
    output [1:0] index,
    output valid
);

    assign valid = |data;
    assign index = (data[3]) ? 2'd3 :
                   (data[2]) ? 2'd2 :
                   (data[1]) ? 2'd1 : 2'd0;
endmodule

