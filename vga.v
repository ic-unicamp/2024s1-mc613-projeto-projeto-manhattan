/*
  Módulo responsável por analisar em que estados estão as transferências

*/
module vga (
    input CLK,           // Clock de 50MHz
    input RESET,         // Entrada para reiniciar o estado do módulo (Ativo alto)
    output reg VGA_CLK,      // Taxa de atualização do VGA
    output VGA_VS,       // Sinal de atualização vertical
    output VGA_HS,       // Sinal de atualização horizontal
    output VGA_SYNC_N,   // Saída que será sempre ativa (Ativo baixo)
    output VGA_BLANK_N,
    output ativo,        //  Indica quando os pixels estão em linha
    output [10:0] sx,
    output [10:0] sy
);

reg [10:0] v_contador;  // Contador da linha que se analisa
reg [10:0] h_contador;   // Contador da coluna que se analisa

always @(posedge CLK) begin
  
  if (RESET) begin
    VGA_CLK = 0;
  end

  VGA_CLK = !VGA_CLK;   // Alterna o clock_out a cada subida do clock_in

end

always @(posedge VGA_CLK) begin
/*
  Always responsável por definir o estado no sentido horizontal
  Foi considerado 25Mhz de frequência
*/    
  if (RESET) begin
    h_contador = 0;
    v_contador = 0;
  end else begin

    h_contador = h_contador + 1;

    if (h_contador == 800) begin
        h_contador = 0;
        v_contador = v_contador + 1;

        if (v_contador == 525) begin
            v_contador = 0;
        end
    end
  end
end // end always

assign VGA_HS = (h_contador < 96) ? 0 : 1;
assign VGA_VS = (v_contador < 2) ? 0 : 1;
assign ativo = ((h_contador > 143) && (v_contador > 34) && (h_contador < 784) && (v_contador < 515)) ? 1 : 0;
assign VGA_BLANK_N = 1;
assign VGA_SYNC_N = 1;
assign sx = (ativo) ? (h_contador - 144) : 0;
assign sy = (ativo) ? (v_contador - 35) : 0;


endmodule