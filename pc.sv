module pc (
  input wire clk, reset, nextinstruction,    
  input wire [2:0] next_pc,
  output reg [2:0] pc    
);

  always @(posedge clk) begin
     if (reset)
        pc <= 3'b000;
     else if (nextinstruction)
        pc <= next_pc;
  end
endmodule