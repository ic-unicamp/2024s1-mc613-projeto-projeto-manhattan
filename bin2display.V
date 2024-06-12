module bin2display(
  input [10:0] bin,
  output reg [6:0] seg2,
  output reg [6:0] seg1,
  output reg [6:0] seg0
);
   
reg [11:0] bcd;

always @(*) begin

  bcd = 0;
  if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;	
	if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
	if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
	bcd = {bcd[10:0],bin[10]};	

  if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;	
	if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
	if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
	bcd = {bcd[10:0],bin[9]};	

  if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;	
	if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
	if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
	bcd = {bcd[10:0],bin[8]};	

  if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;	
	if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
	if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
	bcd = {bcd[10:0],bin[7]};	

  if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;	
	if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
	if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
	bcd = {bcd[10:0],bin[6]};	

  if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;	
	if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
	if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
	bcd = {bcd[10:0],bin[5]};	

  if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;	
	if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
	if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
	bcd = {bcd[10:0],bin[4]};	

  if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;	
	if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
	if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
	bcd = {bcd[10:0],bin[3]};	

  if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;	
	if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
	if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
	bcd = {bcd[10:0],bin[2]};	

  if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;	
	if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
	if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
	bcd = {bcd[10:0],bin[1]};	

  if (bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;	
	if (bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;
	if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
	bcd = {bcd[10:0],bin[0]};
    
	case(bcd[3:0])
		4'b0000: seg0 = 7'b1000000; // 0
		4'b0001: seg0 = 7'b1111001; // 1
		4'b0010: seg0 = 7'b0100100; // 2
		4'b0011: seg0 = 7'b0110000; // 3
		4'b0100: seg0 = 7'b0011001; // 4
		4'b0101: seg0 = 7'b0010010; // 5
		4'b0110: seg0 = 7'b0000010; // 6
		4'b0111: seg0 = 7'b1111000; // 7
		4'b1000: seg0 = 7'b0000000; // 8
		4'b1001: seg0 = 7'b0010000; // 9
		default: seg0 = 7'b1111111; // Entrada inválida
	endcase

  if (bin >= 10) begin
    case(bcd[7:4])
      4'b0000: seg1 = 7'b1000000; // 0
      4'b0001: seg1 = 7'b1111001; // 1
      4'b0010: seg1 = 7'b0100100; // 2
      4'b0011: seg1 = 7'b0110000; // 3
      4'b0100: seg1 = 7'b0011001; // 4
      4'b0101: seg1 = 7'b0010010; // 5
      4'b0110: seg1 = 7'b0000010; // 6
      4'b0111: seg1 = 7'b1111000; // 7
      4'b1000: seg1 = 7'b0000000; // 8
      4'b1001: seg1 = 7'b0010000; // 9
      default: seg1 = 7'b1111111; // Entrada inválida
    endcase

      if (bin >= 100) begin
        case(bcd[11:8])
          4'b0000: seg2 = 7'b1000000; // 0
          4'b0001: seg2 = 7'b1111001; // 1
          4'b0010: seg2 = 7'b0100100; // 2
          4'b0011: seg2 = 7'b0110000; // 3
          4'b0100: seg2 = 7'b0011001; // 4
          4'b0101: seg2 = 7'b0010010; // 5
          4'b0110: seg2 = 7'b0000010; // 6
          4'b0111: seg2 = 7'b1111000; // 7
          4'b1000: seg2 = 7'b0000000; // 8
          4'b1001: seg2 = 7'b0010000; // 9
          default: seg2 = 7'b1111111; // Entrada inválida
        endcase
      end else begin
        seg2 = 7'b1111111;
      end
  end else begin
    seg1 = 7'b1111111;
    seg2 = 7'b1111111;
  end

end

endmodule