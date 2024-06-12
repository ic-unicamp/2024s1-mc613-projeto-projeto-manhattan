module image (
    input clk,
    input reset,
    input [0:255] char,
    input printable,
    output [7:0] VGA_R,
    output [7:0] VGA_G,
    output [7:0] VGA_B
);

parameter size = 255;
reg [10:0] index;

always @(posedge clk) begin
    if (reset) begin
		  index = 0;
    end else if (printable) begin
			if (index == size) begin
				index = 0;
			end else begin
				index = (index + 1);
			end
    end
end

assign VGA_R = (printable) ? (char[index]*255):0;
assign VGA_G = (printable) ? (char[index]*255):0;
assign VGA_B = (printable) ? (char[index]*255):0;

endmodule