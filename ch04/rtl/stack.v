module stack #( 
    parameter DW = 8,
    parameter AW = 4 // DW: DATA_WIDTH, AW: ADDRESS_WIDTH
) (
    input clk, reset, push, pop,
    input [DW-1:0] data_in,
    output [DW-1:0] data_out,
    output full, empty
);
    
    reg [DW-1:0] mem [AW-1:0];
    reg [AW-1:0] pointer;

    assign empty = (pointer == 4'd0);
    assign full = (pointer == (1 << AW)); // IF address is greater then AW it is full;

    assign data_out = (empty) ? {DW{1'b0}} : mem[pointer - 1];

    always @(posedge clk) begin
        if (reset) pointer <= 0;
        else begin
            case({push,pop})
                2'b01: begin // POP CASE
                    if (!empty) pointer <= pointer - 1;
                end
                2'b10: begin // PUSH CASE
                    if (!full) begin
                        mem[pointer] <= data_in;
                        pointer <= pointer + 1'b1;
                    end
                end
                2'b11: begin // PUSH AND POP CASE
                    mem[pointer] <= data_in; // In this case the pointer doesnt get updated we just update the data in the last position
                end
                default : ;
            endcase
        end 
    end


endmodule