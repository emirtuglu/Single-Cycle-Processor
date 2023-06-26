module controller (
  input wire clk,
  input wire [11:0] instr,
  output reg DM_we, DM_re, RF_we, loadSignal, 
  output reg [2:0] ALU_op
);
    reg[3:0] controls;
    assign {DM_we, DM_re, RF_we, loadSignal} = controls;
    
    always_comb begin
        case(instr[11:9])
            3'b000: // load
                controls = 4'b0111;
            3'b001: // store
                controls = 4'b1001;
            3'b010: // sub
                controls = 4'b0010;
            3'b011: // add
                controls = 4'b0010;
            3'b110: // disp
                controls = 4'b0000;
            default:
                controls = 5'bxxxx;
        endcase
    end
    
    always_comb begin
            case(instr[11:9])
                3'b000: // load
                    ALU_op = 3'b001;
                3'b001: // store
                    ALU_op = 3'b001;
                3'b010: // sub
                    ALU_op = 3'b010;
                3'b011: // add
                    ALU_op = 3'b011;
                3'b110: // disp
                    ALU_op = 3'b111;
                default:
                    ALU_op = 5'bxxx;
            endcase
        end
endmodule