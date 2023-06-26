module alu (
  input wire [3:0] src1, src2,
  input wire [2:0] op,
  output reg [3:0] result
);

always_comb begin
    case (op)
        3'b010: // sub
            result = src1 - src2;
        3'b011: // add
            result = src1 + src2;
        3'b111: // disp
            result = src2;
        default:
            result = src2;
    endcase
end
endmodule