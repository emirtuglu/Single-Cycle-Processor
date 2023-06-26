module register_file (
  input wire clk, reset,
  input wire [2:0] RF_ad1, RF_ad2, RF_wa, 
  input wire [3:0] RF_wd,  
  input wire RF_we, RF_external_load,     
  output reg [3:0] RF_d1, 
  output reg [3:0] RF_d2 
);
  reg [3:0] rf [7:0];

  always @(posedge clk) begin
    RF_d1 <= rf[RF_ad1];
    RF_d2 <= rf[RF_ad2];
  end
  
  always @(posedge clk) begin
      if (RF_we | RF_external_load)
          rf[RF_wa] = RF_wd;
      if (reset)
        for (int i = 0; i < 8; i++) 
            rf[i] = 4'b0000;
  end

endmodule