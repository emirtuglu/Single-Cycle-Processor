module instruction_memory (
  input wire clk, reset,
  input wire [2:0] addr,
  input wire [11:0] IM_wd,
  input wire IM_we, isexternal, nextinstruction,
  output reg [11:0] data 
);
  reg [11:0] mem [15:0];
  reg [3:0] count;
  
    always @(posedge clk) begin
        if (reset) begin
            count = 0;
            for (int i = 0; i < 16; i++) 
                mem[i] = 4'b0000;
        end
        else if (IM_we) begin
            mem[count] = IM_wd;
            count = count + 1;
        end
    end
  
    always @(posedge clk) begin
        if (isexternal)
            data <= IM_wd;
        else if (nextinstruction)
            data <= mem[addr];
    end
endmodule