module morse (
    input reset,
    input clk,
    input button0,

    output reg [9:0] saida,
    output [6:0] HEX0
);

wire read;
wire [9:0] temp_array;
wire dot;
wire dash;

wire interchar;
wire interword;

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

receiving inst_receiving (
    //inputs
    .clk(clk),
    .reset(reset),
    .writing(writing),
    .dot(dot),
    .dash(dash),
    .interword(interword),
    .interchar(interchar),

    // outputs
    .read_out(read),
    .data_out(temp_array)
);



always @(posedge clk) begin
    
    if (reset) begin
		saida = 0;
    end else if ((interchar || interword) && temp_array != 0) begin
        saida = temp_array;
    end

end

endmodule