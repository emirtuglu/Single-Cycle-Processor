module instruction_register (
    input wire clk,
    input reg [11:0] instruction_in,
    output reg [11:0] instruction_out
    );
    always @(posedge clk) begin
        instruction_out <= instruction_in;
    end
endmodule