module morse (
    input reset,
    input clk,
    input button0,

    output reg dot_out,
    output reg dash_out,

    output reg interchar_out,
    output reg interword_out,
    output [6:0] HEX0
);

reg read;
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

always @(posedge clk) begin    
    if (reset) begin
        read = 0;
    end else begin
        if (writing) begin
            dot_out = dot;
            dash_out = dash; 
            interchar_out = interchar;   
            interword_out = interword;
            read = 1;
        end else begin
            read = 0;
        end
    end
end

endmodule