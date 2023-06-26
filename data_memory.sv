module data_memory (
  input wire clk, reset,
  input wire [3:0] DM_add, DM_wd, 
  input wire DM_we, DM_re,     
  output reg [3:0] DM_rd  
);
  reg [3:0] mem [15:0];

  always @(posedge clk) begin
      if (reset) 
         for (int i = 0; i < 16; i++) 
            mem[i] = 4'b0000;  
      else if (DM_re)
         DM_rd = mem[DM_add];
      else if (DM_we) 
         mem[DM_add] = DM_wd;
    end
endmodule