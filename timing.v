module timing (
    input button,
    input clk,
    input reset,
    input read,
    output reg dot,
    output reg dash,
    output reg interchar,
    output reg interword,
    output reg writing,
    output reg [3:0] t
);

parameter LIMIAR_counting = 50000000; // 50 million clocks = 1s 

reg [2:0] state;
reg [25:0] counting;
reg restart_time;

always @(posedge clk) begin
    if (reset) begin
        counting = 0;
        t = 0;
    end 
    else if (restart_time) begin
        t = 0;
    end else if (t != 7) begin
        counting = counting + 1;
        if (counting == LIMIAR_counting) begin
            t = t + 1;
            counting = 0;
        end 
    end 
end

always @(posedge clk) begin
    if (reset) begin // if reset activate (high)
        state = 0;
        
        dot = 0;
        dash = 0;

        interchar = 0;
        interword = 0;
        
        writing = 0;
        restart_time = 1;
    end else begin       
        case (state)
            0: begin // não está com botão apertado
                restart_time = 0;
                if (!button) begin 
                    state = 1;
                    writing = 1;
                end
            end 
            1: begin // analise do tempo que ficou sem apertar botão
                if (t <= 3 && t > 1 && !read) begin // espaço entre caracteres
                    interchar = 1;
                end else if (t > 3 && !read) begin
                    interword = 1;
                end else if (read) begin
                    state = 2;
                    interchar = 0;
                    interword = 0;
                    restart_time = 1;
                    writing = 0;
                end
            end
            2: begin
                restart_time = 0;
                if (button) begin
                    state = 3;
                    writing = 1;
                end
            end
            3: begin
                if (t <= 1 && !read) begin
                    dot = 1;
                    dash = 0;
                end else if (t > 1 && !read) begin
                    dash = 1;
                    dot = 0; 
                end else if (read) begin
                    state = 0;
                    dot = 0;
                    dash = 0;
                    restart_time = 1;
                    writing = 0;
                end
                
            end
            default: begin
                state = 0;
                restart_time = 1;
			end
        endcase
    end
end

endmodule