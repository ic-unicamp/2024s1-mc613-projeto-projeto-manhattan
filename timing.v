module timing (
    input button,
    input clk,
    input reset,
    output reg dot,
    output reg dash,
    output reg interchar,
    output reg interword,
    output reg [3:0] t
);

parameter LIMIAR_counting = 50000000; // 50 million clocks = 1s 

reg [25:0] counting;
reg [25:0] counting2;
reg [25:0] contador_1hz;
reg clock_1hz;
reg restart_time;
/*
always @(posedge clk) begin
  if (reset) begin
        counting1 = 0;
        counting2 = 0;
        t1 = 0;
        t2 = 0;
    end else begin
			if (button) begin
				if (counting1 == LIMIAR_counting) begin
					t2 = 0;
					t1 = t1 + 1;
					counting1 = 0;
				end else begin
					counting1 = counting1 + 1;
					counting2 = 0;
				end
			end else begin
				if (counting2 == LIMIAR_counting) begin
					t1 = 0;
					t2 = t2 + 1;
					counting2 = 0;
				end else begin
					counting2 = counting2 + 1;
					counting1 = 0;
				end		
			end
    end 
end
*/
always @(posedge clk) begin
    if (reset) begin
        counting = 0;
        t = 1;
    end 
    else if (restart_time) begin
        t = 1;
    end else if (t != 7) begin
        counting = counting + 1;
        if (counting == LIMIAR_counting) begin
            t = t + 1;
            counting = 1;
        end 
    end 
end
/*
always @(posedge clk) begin
    if (reset) begin
        contador_1hz = 0;
        clock_1hz = 0;
    end else if (contador_1hz == LIMIAR_counting) begin
        clock_1hz = ~clock_1hz;
		contador_1hz = 0;
    end else begin
        contador_1hz = contador_1hz + 1;
	 end
end
*/
reg [1:0] state;
always @(posedge clk) begin
/*
    Timer responsável por analisar tempo em que o botão fica apertado.
    -> 0 a 2 seg (dot)
    -> 2 a 7 seg (dash)

    Quando ambos são zero significa que o não há entrada.
*/
    if (reset) begin
        state = 0;
        
        dot = 0;
        dash = 0;

        interchar = 0;
        interword = 0;
        
        restart_time = 1; // Reseta o tempo
    end else begin       
        case (state)
            0: begin 
            /*
                Caso em que o botão não foi apertado ainda.
            */
                if (!button) begin
                    restart_time = 0;
                    state = 1;
                end else begin
                    restart_time = 1;
                end
            end
            1: begin
            /*
                Caso que analisa quanto tempo o botão ficou apertado.
            */
                interchar = 0;
                interword = 0;
                restart_time = (button) ? 1:0;
                dot = ((t <= 2) && button) ? 1:0;
                dash = (button) ? !dot:0;
                state = (button) ? 2:1; 
            end
            2: begin
                dot = 0;
                dash = 0;
                interchar = ((t > 2) && (t <= 4) && !button) ? 1:0;
                interword = ((t > 4) && !button) ? 1:0;
                restart_time = (!button) ? 1:0;
                state = (!button) ? 1:2;
            end
            default: begin
                state = 0;
                
                dot = 0;
                dash = 0;

                interchar = 0;
                interword = 0;
                
                restart_time = 1; // Reseta o tempo
                    end
        endcase
    end
end

endmodule