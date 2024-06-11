module morse (
    input reset,
    input clk,
    input button0,

    //output reg [9:0] saida,
    output reg dot_out,
    output reg dash_out,
    output reg interword_out,
    output reg interchar_out,
    output [6:0] HEX0
);

wire read;
wire [9:0] temp_array;

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

    // outputs
    .dot(dot),
    .dash(dash),
    .interchar(interchar),
    .interword(interword),
    .t(tempo)
);

always @(posedge clk) begin
    if (reset) begin
        dot_out = 0;
        dash_out = 0;
        interchar_out = 0;
        interword_out = 0;
    end else begin
        /*
        if (dot || dash || interchar || interword) begin
            dot_out = dot;
            dash_out = dash;
            interchar_out = interchar;
            interword_out = interword;
        end
        */
            dot_out = dot;
            dash_out = dash;
            interchar_out = interchar;
            interword_out = interword;
    end
end


endmodule