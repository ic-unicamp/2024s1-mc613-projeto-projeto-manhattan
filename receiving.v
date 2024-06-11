module receiving (
    input clk,
    input reset,
    input writing,
    input dot,
    input dash,
    input interword,
    input interchar,

    output reg read_out,
    output reg [9:0] data_out,
    output reg space
);

reg [5:0] state;



endmodule