module receiving (
    input clk,
    input reset,
    input writing,
    input dot,
    input dash,
    input interword,
    input interchar,
    input read_in,
    output reg read_out,
    output reg [9:0] data_out,
    output reg complete
);

reg [5:0] state;

always @(posedge clk) begin
    if (reset) begin
        state = 0;
    end else begin
        case (state)
            0:  
            default: 
        endcase
    end
end

endmodule