module morse (
    input reset,
    input clk,
    input button0,

    output reg [9:0] saida,
    output [6:0] HEX0,  // display para o contador em segundos
	 output [6:0] HEX5,
    output [6:0] HEX4,
    output VGA_CLK,      // Taxa de atualização do VGA
    output VGA_VS,       // Sinal de atualização vertical
    output VGA_HS,       // Sinal de atualização horizontal
    output VGA_SYNC_N,   // Saída que será sempre ativa (Ativo baixo)
    output VGA_BLANK_N,
	 output [7:0] VGA_R,
	 output [7:0] VGA_G,
	 output [7:0] VGA_B
);

wire [9:0] temp_array;
wire [3:0] tempo;
wire [5:0] estado;
wire [4:0] index;
wire [0:255] data;
wire interchar;
wire interword;
wire dot;
wire dash;

timer inst_timer(
    .numero(tempo),
    .segmentos(HEX0)
);

morse2hex inst_display(
  .morse_code(estado), // Considerando que os valores dos parâmetros não excedem 62
  .hex_display1(HEX4), // Display hexadecimal ativo alto
  .hex_display2(HEX5)
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

receiving inst_receiving (
    // inputs
    .clk(clk),
    .reset(reset),
    .dot(dot),
    .dash(dash),
    .interword(interword),
    .interchar(interchar),

    // outputs
    .data_out(data_out),
    .state(estado)
);

wire [10:0] sx;
wire [10:0] sy;
wire ativo;

vga vga_inst(
    .CLK(clk),           // Clock de 50MHz
    .RESET(reset),         // Entrada para reiniciar o estado do módulo (Ativo alto)
    .VGA_CLK(VGA_CLK),      // Taxa de atualização do VGA
    .VGA_VS(VGA_VS),       // Sinal de atualização vertical
    .VGA_HS(VGA_HS),       // Sinal de atualização horizontal
    .VGA_SYNC_N(VGA_SYNC_N),   // Saída que será sempre ativa (Ativo baixo)
    .VGA_BLANK_N(VGA_BLANK_N),
    .ativo(ativo),        //  Indica quando os pixels estão em linha
    .sx(sx),
    .sy(sy)
);


screen screen_inst(
    .clk(clk),
    .interword(interword),
    .interchar(interchar),
    .code(data_out),
    .data(data),
    .reset(reset),         
    .VGA_CLK(VGA_CLK),  
    .ativo(ativo),    
    .sx(sx),
    .sy(sy),
    .VGA_R(VGA_R),
    .VGA_G(VGA_G),
    .VGA_B(VGA_B),
    .area_index(index)
);

wire [9:0] data_out;
always @(posedge clk) begin
    if (reset) begin
        saida = 10'b1111111111;
    end else if (data_out != 0) begin
        saida = data_out;
    end 
end


endmodule