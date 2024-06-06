module morse (
    input reset,
    input clk,
    input button0,

    output reg [9:0] saida,
    output [6:0] HEX0
);

wire read;
reg read_in;
wire [9:0] temp_array;
wire dot;
wire dash;

wire interchar;
wire interword;

wire complete;
wire writing;
wire [3:0] tempo;

timer inst_timer(
    .numero(tempo),
    .segmentos(HEX0)
);

timing inst_timing (
    // inputs    
    .button(button0),
    .clk(clk),
    .reset(reset),
    .read(read),

    // outputs
    .dot(dot),
    .dash(dash),
    .interchar(interchar),
    .interword(interword),
    .writing(writing),
    .t(tempo)
);

receiving inst_receiving(
    // inputs
    .clk(clk),
    .reset(reset),
    .writing(writing),
    .dot(dot),
    .dash(dash),
    .interchar(interchar),
    .read_in(read_in),

    // outputs
    .read_out(read),
    .data_out(temp_array),
    .complete(complete)
);


always @(posedge clk) begin
    
    if (reset) begin
        read_in = 0;
		  saida = 0;
    end else if (complete) begin
        saida = temp_array;
        read_in = 1;
    end else begin
        read_in = 0;
    end
end


endmodule