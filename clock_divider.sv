`timescale 1ns / 1ps

module clockDivider(clk, reset, clk_1Hz);
    input clk, reset;
    output clk_1Hz;
    
    reg clk_1Hz = 1'b0;
    reg [27:0] counter;
    
    always@(posedge reset or posedge clk)
    begin
        if (reset == 1'b1)
            begin
                clk_1Hz <= 0;
                counter <= 0;
            end
        else
            begin
                counter <= counter + 1;
                if ( counter == 25_000_000)
                    begin
                        counter <= 0;
                        clk_1Hz <= ~clk_1Hz;
                    end
            end
    end
    endmodule 