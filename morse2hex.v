module morse2hex (
  input [5:0] morse_code, // Considerando que os valores dos parâmetros não excedem 62
  output reg [6:0] hex_display1, // direita
  output reg [6:0] hex_display2 // esquerda
);

always @(*) begin
  case (morse_code)
    1: begin 
      hex_display1 = 7'b0000110;  // E
      hex_display2 = 7'b1111111;
    end
    2: begin 
      hex_display1 = 7'b0000111;  // T
      hex_display2 = 7'b1111111;
    end
    3: begin 
      hex_display1 = 7'b1111001;  // I
      hex_display2 = 7'b1111111;
    end
    4: begin 
      hex_display1 = 7'b0001000;  // A
      hex_display2 = 7'b1111111;
    end
    5: begin 
      hex_display1 = 7'b1001111;  // N
      hex_display2 = 7'b1001000;
    end
    6: begin 
      hex_display1 = 7'b1011000;  // M
      hex_display2 = 7'b1001100;
    end
    7: begin 
      hex_display1 = 7'b0010010;  // S
      hex_display2 = 7'b1111111;
    end
    8: begin 
      hex_display1 = 7'b10000001;  // U
      hex_display2 = 7'b1111111;
    end
    9: begin 
      hex_display1 = 7'b0001100;  // R
      hex_display2 = 7'b1101111;
    end
    10: begin
      hex_display1 = 7'b1100001; // W
		  hex_display2 = 7'b1000011;
    end
    11: begin
       hex_display1 = 7'b0100001; // D
      hex_display2 = 7'b1111111;
    end
    12: begin
       hex_display1 = 7'b0001011; // K
      hex_display2 = 7'b1111111;
    end
    13: begin
       hex_display1 = 7'b0110011; // G
      hex_display2 = 7'b1000110;
    end
    14: begin
       hex_display1 = 7'b0100011; // O
      hex_display2 = 7'b1111111;
    end
    15: begin
      hex_display1 = 7'b0001011; // H
      hex_display2 = 7'b1111111;
    end
    16: begin
      hex_display1 = 7'b1100011; // V
      hex_display2 = 7'b1111111;
    end
    17: begin
       hex_display1 = 7'b0001110; // F
      hex_display2 = 7'b1111111;
    end
    18: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    19: begin
       hex_display1 = 7'b1000111; // L
      hex_display2 = 7'b1111111;
    end
    20: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    21: begin
       hex_display1 = 7'b0001100; // P
      hex_display2 = 7'b1111111;
    end
    22: begin
       hex_display1 = 7'b1110001; // J
      hex_display2 = 7'b1111111;
    end
    23: begin
      hex_display1 = 7'b0000011; // B
      hex_display2 = 7'b1111111;
    end
    24: begin
       hex_display1 = 7'b1000110; // X
      hex_display2 = 7'b1110000;
    end
    25: begin
       hex_display1 = 7'b1000110; // C
      hex_display2 = 7'b1111111;
    end
    26: begin
       hex_display1 = 7'b0010001; // Y
      hex_display2 = 7'b1111111;
    end
    27: begin
       hex_display1 = 7'b0000111; // Z
      hex_display2 = 7'b0111000;
    end
    28: begin
       hex_display1 = 7'b1110111; // Q
      hex_display2 = 7'b1000000;
    end
    29: begin
      hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    30: begin
      hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    31: begin
       hex_display1 = 7'b0010010; // 5
      hex_display2 = 7'b1111111;
    end
    32: begin
       hex_display1 = 7'b0011001; // 4
      hex_display2 = 7'b1111111;
    end
    33: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    34: begin
       hex_display1 = 7'b0110000; // 3
      hex_display2 = 7'b1111111;
    end
    35: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    36: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    37: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    38: begin
       hex_display1 = 7'b0100101; // 2
      hex_display2 = 7'b1111111;
    end
    39: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    40: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    41: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    42: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    43: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    44: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    45: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    46: begin
       hex_display1 = 7'b0100100; // 1
      hex_display2 = 7'b1111111;
    end
    47: begin
       hex_display1 = 7'b0100101; // 6
      hex_display2 = 7'b1111111;
    end
    48: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    49: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    50: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    51: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    52: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    53: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    54: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    55: begin
       hex_display1 = 7'b1111000; // 7
      hex_display2 = 7'b1111111;
    end
    56: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    57: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    58: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    59: begin
       hex_display1 = 7'b0000000; // 8
      hex_display2 = 7'b1111111;
    end
    60: begin
       hex_display1 = 7'b1111111; // Não representado
      hex_display2 = 7'b1111111;
    end
    61: begin
       hex_display1 = 7'b0010000; // 9
      hex_display2 = 7'b1111111;
    end
    62: begin
       hex_display1 = 7'b1000000; // 0
      hex_display2 = 7'b1111111;
    end
    default: hex_display1 = 7'b1111111; // Desligado
  endcase
end

endmodule
