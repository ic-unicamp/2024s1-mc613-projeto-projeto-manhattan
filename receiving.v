module receiving (
    input clk,
    input reset,
    input dot,
    input dash,
    input interword,
    input interchar,

    output reg [6:0] data_out,
    output reg [5:0] state
);

parameter dt = 1;       // dot                              E
parameter ds = 2;       // dash                             T
parameter dtdt = 3;     // dot dot                          I
parameter dtds = 4;     // dot dash                         A
parameter dsdt = 5;      // dash dot                        N
parameter dsds = 6;      // dash dash                       M
parameter dtdtdt = 7;    // dot dot dot                     S
parameter dtdtds = 8;    // dot dot dash                    U
parameter dtdsdt = 9;    // dot dash dot                    R
parameter dtdsds = 10;   // dot dash dash                   W
parameter dsdtdt = 11;   // dash dot dot                    D
parameter dsdtds = 12;   // dash dot dash                   K  
parameter dsdsdt = 13;   // dash dash dot                   G
parameter dsdsds = 14;   // dash dash dash                  O
parameter dtdtdtdt = 15; // dot dot dot dot                 H
parameter dtdtdtds = 16; // dot dot dot dash                V
parameter dtdtdsdt = 17; // dot dot dash dot                F
parameter dtdtdsds = 18; // dot dot dash dash               
parameter dtdsdtdt = 19; // dot dash dot dot                L
parameter dtdsdtds = 20; // dot dash dot dash               
parameter dtdsdsdt = 21; // dot dash dash dot               P
parameter dtdsdsds = 22; // dot dash dash dash              J
parameter dsdtdtdt = 23; // dash dot dot dot                B
parameter dsdtdtds = 24; // dash dot dot dash               X
parameter dsdtdsdt = 25; // dash dot dash dot               C
parameter dsdtdsds = 26; // dash dot dash dash              Y
parameter dsdsdtdt = 27; // dash dash dot dot               Z
parameter dsdsdtds = 28; // dash dash dot dash              Q
parameter dsdsdsdt = 29; // dash dash dash dot
parameter dsdsdsds = 30; // dash dash dash dash
parameter dtdtdtdtdt = 31; // dot dot dot dot dot           5
parameter dtdtdtdtds = 32; // dot dot dot dot dash          4
parameter dtdtdtdsdt = 33; // dot dot dot dash dot
parameter dtdtdtdsds = 34; // dot dot dot dash dash         3
parameter dtdtdsdtdt = 35; // dot dot dash dot dot
parameter dtdtdsdtds = 36; // dot dot dash dot dash
parameter dtdtdsdsdt = 37; // dot dot dash dash dot
parameter dtdtdsdsds = 38; // dot dot dash dash dash        2
parameter dtdsdtdtdt = 39; // dot dash dot dot dot
parameter dtdsdtdtds = 40; // dot dash dot dot dash
parameter dtdsdtdsdt = 41; // dot dash dot dash dot
parameter dtdsdtdsds = 42; // dot dash dot dash dash
parameter dtdsdsdtdt = 43; // dot dash dash dot dot
parameter dtdsdsdtds = 44; // dot dash dash dot dash
parameter dtdsdsdsdt = 45; // dot dash dash dash dot
parameter dtdsdsdsds = 46; // dot dash dash dash dash       1
parameter dsdtdtdtdt = 47; // dash dot dot dot dot          6
parameter dsdtdtdtds = 48; // dash dot dot dot dash
parameter dsdtdtdsdt = 49; // dash dot dot dash dot
parameter dsdtdtdsds = 50; // dash dot dot dash dash
parameter dsdtdsdtdt = 51; // dash dot dash dot dot
parameter dsdtdsdtds = 52; // dash dot dash dot dash
parameter dsdtdsdsdt = 53; // dash dot dash dash dot
parameter dsdtdsdsds = 54; // dash dot dash dash dash
parameter dsdsdtdtdt = 55; // dash dash dot dot dot         7
parameter dsdsdtdtds = 56; // dash dash dot dot dash
parameter dsdsdtdsdt = 57; // dash dash dot dash dot
parameter dsdsdtdsds = 58; // dash dash dot dash dash
parameter dsdsdsdtdt = 59; // dash dash dash dot dot        8
parameter dsdsdsdtds = 60; // dash dash dash dot dash
parameter dsdsdsdsdt = 61; // dash dash dash dash dot       9
parameter dsdsdsdsds = 62; // dash dash dash dash dash      0



always @(posedge clk) begin
    if (reset) begin
        data_out = 0; // Null
        state = 0;
    end else begin
        case (state)
            0: begin
                if (dot) begin
                    state = 1;
                end else if (dash) begin
                    state = 2;
                end else begin
                   data_out = 0; // Null
                end
            end
            1: begin // está em => dot
                if (dot) begin // vai para => dot dot
                    state = 3;
                end else if (dash) begin // vai para => dot dash
                    state = 4;
                end else if (interchar || interword) begin
                    data_out = dt;
                    state = 0;
                end else begin
                    state = 1;
                end

            end
            2: begin // está em => dash
                if (dot) begin  // vai para => dash dot
                    state = 5;
                end else if (dash) begin // vai para => dash dash
                    state = 6;
                end else if (interchar || interword) begin
                    data_out = ds;
                    state = 0;
                end else begin
                    state = 2;
                end
            end
            3: begin  // está  em => dot dot
                if (dot) begin  // vai para => dot dot dot
                    state = 7;
                end else if (dash) begin // vai para => dot dot dash
                    state = 8;
                end else if (interchar || interword) begin
                    data_out = dtdt;
                    state = 0;
                end else begin
                    state = 3;
                end
            end
            4: begin    // está em => dot dash
                if (dot) begin  // vai para => dot dash dot
                    state = 9;
                end else if (dash) begin // vai para => dot dash dash
                    state = 10;
                end else if (interchar || interword) begin
                    data_out = dtds;
                    state = 0;
                end else begin
                    state = 4;
                end
            end
            5: begin    // está em => dash dot
                if (dot) begin  // vai para => dash dot dot 
                    state = 11;
                end else if (dash) begin // vai para => dash dot dash
                    state = 12;
                end else if (interchar || interword) begin
                    data_out = dsdt;
                    state = 0;
                end else begin
                    state = 5;
                end
            end
            
            6: begin    // está em => dash dash
                if (dot) begin  // vai para => dash dash dot 
                    state = 13;
                end else if (dash) begin // vai para => dash dash dash
                    state = 14;
                end else if (interchar || interword) begin
                    data_out = dsds;
                    state = 0;
                end else begin
                    state = 6;
                end
            end
            
            7: begin    // está em => dot dot dot
                if (dot) begin  // vai para => dot dot dot dot
                    state = 15;
                end else if (dash) begin // vai para => dot dot dot dash
                    state = 16;
                end else if (interchar || interword) begin
                    data_out = dtdtdt;
                    state = 0;
                end else begin
                    state = 7;
                end
            end
            
            8: begin    // está em => dot dot dash
                if (dot) begin  // vai para => dot dot dash dot
                    state = 17;
                end else if (dash) begin // vai para => dot dot dash dash
                    state = 18;
                end else if (interchar || interword) begin
                    data_out = dtdtds;
                    state = 0;
                end else begin
                    state = 8;
                end
            end                      

            9: begin    // está em => dot dash dot
                if (dot) begin  // vai para => dot dash dot dot
                    state = 19;
                end else if (dash) begin // vai para => dot dash dot dash
                    state = 20;
                end else if (interchar || interword) begin
                    data_out = dtdsdt;
                    state = 0;
                end else begin
                    state = 9;
                end
            end 
            
            10: begin    // está em => dot dash dash
                if (dot) begin  // vai para => dot dash dash dot
                    state = 21;
                end else if (dash) begin // vai para => dot dash dash dash
                    state = 22;
                end else if (interchar || interword) begin
                    data_out = dtdsds;
                    state = 0;
                end else begin
                    state = 10;
                end
            end 

           11: begin    // está em => dash dot dot
                if (dot) begin  // vai para => dash dot dot dot
                    state = 23;
                end else if (dash) begin // vai para => dash dot dot dash
                    state = 24;
                end else if (interchar || interword) begin
                    data_out = dsdtdt;
                    state = 0;
                end else begin
                    state = 11;
                end
            end

            12: begin    // está em => dash dot dash
                if (dot) begin  // vai para => dash dot dash dot 
                    state = 25;
                end else if (dash) begin // vai para => dash dot dash dash
                    state = 26;
                end else if (interchar || interword) begin
                    data_out = dsdtds;
                    state = 0;
                end else begin
                    state = 12;
                end
            end
            13: begin    // está em => dash dash dot 
                if (dot) begin  // vai para => dash dash dot dot
                    state = 27;
                end else if (dash) begin // vai para => dash dash dot dash
                    state = 28;
                end else if (interchar || interword) begin
                    data_out = dsdsdt;
                    state = 0;
                end else begin
                    state = 13;
                end
            end
            
            14: begin    // está em => dash dash dash
                if (dot) begin  // vai para => dash dash dash dot 
                    state = 29;
                end else if (dash) begin // vai para => dash dash dash dash
                    state = 30;
                end else if (interchar || interword) begin
                    data_out = dsdsds;
                    state = 0;
                end else begin
                    state = 14;
                end
            end

            15: begin    // está em => dot dot dot dot
                if (dot) begin  // vai para => dot dot dot dot dot  
                    state = 31;
                end else if (dash) begin // vai para => dot dot dot dot dash
                    state = 32;
                end else if (interchar || interword) begin
                    data_out = dtdtdtdt;
                    state = 0;
                end else begin
                    state = 15;
                end
            end

            16: begin    // está em => dot dot dot dash
                if (dot) begin  // vai para => dot dot dot dash dot
                    state = 33;
                end else if (dash) begin // vai para => dot dot dot dash dash
                    state = 34;
                end else if (interchar || interword) begin
                    data_out = dtdtdtds;
                    state = 0;
                end else begin
                    state = 16;
                end
            end

            17: begin    // está em => dot dot dash dot
                if (dot) begin  // vai para => dot dot dash dot dot
                    state = 35;
                end else if (dash) begin // vai para => dot dot dash dot dash
                    state = 36;
                end else if (interchar || interword) begin
                    data_out = dtdtdsdt;
                    state = 0;
                end else begin
                    state = 17;
                end
            end

            18: begin    // está em => dot dot dash dash
                if (dot) begin  // vai para => dot dot dash dash dot
                    state = 37;
                end else if (dash) begin // vai para => dot dot dash dash dash
                    state = 38;
                end else if (interchar || interword) begin
                    data_out = dtdtdsds;
                    state = 0;
                end else begin
                    state = 18;
                end
            end

            19: begin    // está em => dot dash dot dot
                if (dot) begin  // vai para => dot dash dot dot dot
                    state = 39;
                end else if (dash) begin // vai para => dot dash dot dot dash
                    state = 40;
                end else if (interchar || interword) begin
                    data_out = dtdsdtdt;
                    state = 0;
                end else begin
                    state = 19;
                end
            end

            20: begin    // está em => dot dash dot dash
                if (dot) begin  // vai para => dot dash dot dash dot
                    state = 41;
                end else if (dash) begin // vai para => dot dash dot dash dash
                    state = 42;
                end else if (interchar || interword) begin
                    data_out = dtdsdtds;
                    state = 0;
                end else begin
                    state = 20;
                end
            end

            21: begin    // está em => dot dash dash dot
                if (dot) begin  // vai para => dot dash dash dot dot
                    state = 43;
                end else if (dash) begin // vai para => dot dash dash dot dash
                    state = 44;
                end else if (interchar || interword) begin
                    data_out = dtdsdsdt;
                    state = 0;
                end else begin
                    state = 21;
                end
            end

            22: begin    // está em => dot dash dash dash
                if (dot) begin  // vai para => dot dash dash dash dot
                    state = 45;
                end else if (dash) begin // vai para => dot dash dash dash dash
                    state = 46;
                end else if (interchar || interword) begin
                    data_out = dtdsdsds;
                    state = 0;
                end else begin
                    state = 22;
                end
            end

            23: begin    // está em => dash dot dot dot
                if (dot) begin  // vai para => dash dot dot dot dot
                    state = 47;
                end else if (dash) begin // vai para => dash dot dot dot dash
                    state = 48;
                end else if (interchar || interword) begin
                    data_out = dsdtdtdt;
                    state = 0;
                end else begin
                    state = 23;
                end
            end

            24: begin    // está em => dash dot dot dash
                if (dot) begin  // vai para => dash dot dot dash dot
                    state = 49;
                end else if (dash) begin // vai para => dash dot dot dash dash
                    state = 50;
                end else if (interchar || interword) begin
                    data_out = dsdtdtds;
                    state = 0;
                end else begin
                    state = 24;
                end
            end

            25: begin    // está em => dash dot dash dot
                if (dot) begin  // vai para => dash dot dash dot dot
                    state = 51;
                end else if (dash) begin // vai para => dash dot dash dot dash
                    state = 52;
                end else if (interchar || interword) begin
                    data_out = dsdtdsdt;
                    state = 0;
                end else begin
                    state = 25;
                end
            end

            26: begin    // está em => dash dot dash dash
                if (dot) begin  // vai para => dash dot dash dash dot
                    state = 53;
                end else if (dash) begin // vai para => dash dot dash dash dash
                    state = 54;
                end else if (interchar || interword) begin
                    data_out = dsdtdsds;
                    state = 0;
                end else begin
                    state = 26;
                end
            end

            27: begin    // está em => dash dash dot dot
                if (dot) begin  // vai para => dash dash dot dot dot
                    state = 55;
                end else if (dash) begin // vai para => dash dash dot dot dash
                    state = 56;
                end else if (interchar || interword) begin
                    data_out = dsdsdtdt;
                    state = 0;
                end else begin
                    state = 27;
                end
            end

            28: begin    // está em => dash dash dot dash
                if (dot) begin  // vai para => dash dash dot dash dot
                    state = 57;
                end else if (dash) begin // vai para => dash dash dot dash dash
                    state = 58;
                end else if (interchar || interword) begin
                    data_out = dsdsdtds;
                    state = 0;
                end else begin
                    state = 28;
                end
            end

            29: begin    // está em => dash dash dash dot
                if (dot) begin  // vai para => dash dash dash dot dot
                    state = 59;
                end else if (dash) begin // vai para => dash dash dash dot dash
                    state = 60;
                end else if (interchar || interword) begin
                    data_out = dsdsdsds;
                    state = 0;
                end else begin
                    state = 29;
                end
            end

            30: begin    // está em => dash dash dash dash
                if (dot) begin  // vai para => dash dash dash dash dot
                    state = 61;
                end else if (dash) begin // vai para => dash dash dash dash dash
                    state = 62;
                end else if (interchar || interword) begin
                    data_out = dsdsdsds;
                    state = 0;
                end else begin
                    state = 30;
                end
            end

            31: begin  // está em => dot dot dot dot dot
                if (interchar || interword) begin
                    data_out = dtdtdtdtdt;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            32: begin  // está em => dot dot dot dot dash
                if (interchar || interword) begin
                    data_out = dtdtdtdtds;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            33: begin  // está em => dot dot dot dash dot
                if (interchar || interword) begin
                    data_out = dtdtdtdsdt;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            34: begin  // está em => dot dot dot dash dash
                if (interchar || interword) begin
                    data_out = dtdtdtdsds;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            35: begin  // está em => dot dot dash dot dot
                if (interchar || interword) begin
                    data_out = dtdtdsdtdt;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            36: begin  // está em => dot dot dash dot dash
                if (interchar || interword) begin
                    data_out = dtdtdsdtds;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            37: begin  // está em => dot dot dash dash dot
                if (interchar || interword) begin
                    data_out = dtdtdsdsdt;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            38: begin  // está em => dot dot dash dash dash
                if (interchar || interword) begin
                    data_out = dtdtdsdsds;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            39: begin  // está em => dot dash dot dot dot
                if (interchar || interword) begin
                    data_out = dtdsdtdtdt;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            40: begin  // está em => dot dash dot dot dash
                if (interchar || interword) begin
                    data_out = dtdsdtdtds;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            41: begin  // está em => dot dash dot dash dot
                if (interchar || interword) begin
                    data_out = dtdsdtdsdt;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            42: begin  // está em => dot dash dot dash dash
                if (interchar || interword) begin
                    data_out = dtdsdtdsds;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            43: begin  // está em => dot dash dash dot dot
                if (interchar || interword) begin
                    data_out = dtdsdsdtdt;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            44: begin  // está em => dot dash dash dot dash
                if (interchar || interword) begin
                    data_out = dtdsdsdtds;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            45: begin  // está em => dot dash dash dash dot
                if (interchar || interword) begin
                    data_out = dtdsdsdsdt;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            46: begin  // está em => dot dash dash dash dash
                if (interchar || interword) begin
                    data_out = dtdsdsdsds;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            47: begin  // está em => dash dot dot dot dot
                if (interchar || interword) begin
                    data_out = dsdtdtdtdt;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            48: begin  // está em => dash dot dot dot dash
                if (interchar || interword) begin
                    data_out = dsdtdtdtds;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            49: begin  // está em => dash dot dot dash dot
                if (interchar || interword) begin
                    data_out = dsdtdtdsdt;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            50: begin  // está em => dash dot dot dash dash
                if (interchar || interword) begin
                    data_out = dsdtdtdsds;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            51: begin  // está em => dash dot dash dot dot
                if (interchar || interword) begin
                    data_out = dsdtdsdtdt;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            52: begin  // está em => dash dot dash dot dash
                if (interchar || interword) begin
                    data_out = dsdtdsdtds;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            53: begin  // está em => dash dot dash dash dot
                if (interchar || interword) begin
                    data_out = dsdtdsdsdt;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            54: begin  // está em => dash dot dash dash dash
                if (interchar || interword) begin
                    data_out = dsdtdsdsds;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            55: begin  // está em => dash dash dot dot dot
                if (interchar || interword) begin
                    data_out = dsdsdtdtdt;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            56: begin  // está em => dash dash dot dot dash
                if (interchar || interword) begin
                    data_out = dsdsdtdtds;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            57: begin  // está em => dash dash dot dash dot
                if (interchar || interword) begin
                    data_out = dsdsdtdsdt;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            58: begin  // está em => dash dash dot dash dash
                if (interchar || interword) begin
                    data_out = dsdsdtdsds;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            59: begin  // está em => dash dash dash dot dot
                if (interchar || interword) begin
                    data_out = dsdsdsdtdt;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            60: begin  // está em => dash dash dash dot dash
                if (interchar || interword) begin
                    data_out = dsdsdsdtds;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            61: begin  // está em => dash dash dash dash dot
                if (interchar || interword) begin
                    data_out = dsdsdsdsdt;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            62: begin  // está em => dash dash dash dash dash
                if (interchar || interword) begin
                    data_out = dsdsdsdsds;
                    state = 0;
                end else if (dot || dash) begin
                    state = 0;
                end
            end

            default: begin
                data_out = 0;
                state = 0;
            end 
        endcase
    end
end

endmodule