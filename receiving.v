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

always @(posedge clk) begin
    if (reset) begin
        state = 0;
        read_out = 0;
        data_out = 0;
    end else begin
        case (state)
            0: begin
                read_out = 0;
                if (writing) begin
                    data_out = 0;
                    if (dot) begin
                        state = 1; // estado ímpar sempre para dot
                        read_out = 1;
                    end else if (dash) begin
                        state = 2; // estado par sempre para dash
                        read_out = 1;
                    end else if (interchar || interword) begin
                        read_out = 1;
                    end
                end
            end
            1: begin // dot
                read_out = 0;
                if (writing) begin
                    data_out = 0;
                    if (dot) begin
                        state = 3; // estado ímpar sempre para dot
                        read_out = 1;
                    end else if (dash) begin
                        state = 4; // estado par sempre para dash
                        read_out = 1;
                    end else if (interword || interchar) begin
                        data_out = 10'b1000000000;
                        read_out = 1;
                        state = 0; // sempre que for interword ou interchar vai para o estado 0
                    end 
                end
            end
            2: begin // dash
                read_out = 0;
                if (writing) begin
                    data_out = 0;
                    if (dot) begin
                        state = 5; // estado ímpar sempre para dot
                        read_out = 1;
                    end else if (dash) begin
                        state = 6; // estado par sempre para dash
                        read_out = 1;
                    end else if (interword || interchar) begin
                        data_out = 10'b1100000000;
                        read_out = 1;
                        state = 0; // sempre que for interword ou interchar vai para o estado 0
                    end 
                end
            end
            3: begin // dot dot
                read_out = 0;
                if (writing) begin
                    data_out = 0;
                    if (dot) begin
                        state = 7; // estado ímpar sempre para dot
                        read_out = 1;
                    end else if (dash) begin
                        state = 8; // estado par sempre para dash
                        read_out = 1;
                    end else if (interword || interchar) begin
                        data_out = 10'b1010000000;
                        read_out = 1;
                        state = 0; // sempre que for interword ou interchar vai para o estado 0
                    end 
                end
            end
            4: begin // dot dash
                read_out = 0;
                if (writing) begin
                    data_out = 0;
                    if (dot) begin
                        state = 9; // estado ímpar sempre para dot
                        read_out = 1;
                    end else if (dash) begin
                        state = 10; // estado par sempre para dash
                        read_out = 1;
                    end else if (interword || interchar) begin
                        data_out = 10'b1011000000;
                        read_out = 1;
                        state = 0; // sempre que for interword ou interchar vai para o estado 0
                    end 
                end
            end
            5: begin // dash dot
                read_out = 0;
                if (writing) begin
                    data_out = 0;
                    if (dot) begin
                        state = 11; // estado ímpar sempre para dot
                        read_out = 1;
                    end else if (dash) begin
                        state = 12; // estado par sempre para dash
                        read_out = 1;
                    end else if (interword || interchar) begin
                        data_out = 10'b1101000000;
                        read_out = 1;
                        state = 0; // sempre que for interword ou interchar vai para o estado 0
                    end 
                end
            end
            6: begin // dash dash
                read_out = 0;
                if (writing) begin
                    data_out = 0;
                    if (dot) begin
                        state = 13; // estado ímpar sempre para dot
                        read_out = 1;
                    end else if (dash) begin
                        state = 14; // estado par sempre para dash
                        read_out = 1;
                    end else if (interword || interchar) begin
                        data_out = 10'b1101100000;
                        read_out = 1;
                        state = 0; // sempre que for interword ou interchar vai para o estado 0
                    end 
                end
            end
            7: begin // dot dot dot
                read_out = 0;
                if (writing) begin
                    data_out = 0;
                    if (dot) begin
                        state = 15; // estado ímpar sempre para dot
                        read_out = 1;
                    end else if (dash) begin
                        state = 16; // estado par sempre para dash
                        read_out = 1;
                    end else if (interword || interchar) begin
                        data_out = 10'b1010100000;
                        read_out = 1;
                        state = 0; // sempre que for interword ou interchar vai para o estado 0
                    end 
                end
            end
            8: begin // dot dot dash
                read_out = 0;
                if (writing) begin
                    data_out = 0;
                    if (dot) begin
                        state = 17; // estado ímpar sempre para dot
                        read_out = 1;
                    end else if (dash) begin
                        state = 18; // estado par sempre para dash
                        read_out = 1;
                    end else if (interword || interchar) begin
                        data_out = 10'b1010100000;
                        read_out = 1;
                        state = 0; // sempre que for interword ou interchar vai para o estado 0
                    end 
                end
            end
            default: begin
				  state = 0;
					read_out = 0;
					data_out = 0;
			end 	
        endcase
    end
end

endmodule