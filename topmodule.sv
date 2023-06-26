`timescale 1ns / 1ps
    
module topmodule (
    input logic clk, reset, next_instruction, isexternal, IM_we, RF_external_load,
    input logic [15:0] sw,
    output logic [3:0] an,
    output logic [6:0] seg,
    output logic dp
    );
    
    wire DM_we, DM_re, RF_we, loadSignal;
    wire [2:0] ALU_op;
    wire [11:0] IM_out;
    wire[3:0] RF_d1, RF_d2, ALU_out;
    reg clk_1Hz;
    
    clockDivider clock_div (clk, reset, clk_1Hz);
    control_unit cu (clk_1Hz, reset_pulse, next_pulse, isexternal_pulse, IM_we_pulse, sw[11:0],
        DM_we, DM_re, RF_we, loadSignal, ALU_op, IM_out);
    datapath datapath (clk_1Hz, reset_pulse, IM_out, DM_we, DM_re, RF_we, loadSignal, RF_ext_pulse,
        ALU_op, sw[11:9], sw[15:12], RF_d1, RF_d2, ALU_out);
    
    logic [3:0] in3, in2, in1, in0;
    logic reset_pulse, next_pulse, isexternal_pulse, IM_we_pulse, RF_ext_pulse;
    
    display_controller dc (clk, in3, in2, in1, in0, seg, dp, an);
    pulse_controller resetp (.CLK(clk), .sw_input(reset), .clk_pulse(reset_pulse));
    pulse_controller nextp (.CLK(clk), .sw_input(next_instruction), .clk_pulse(next_pulse));
    pulse_controller isextp (.CLK(clk), .sw_input(isexternal), .clk_pulse(isexternal_pulse));
    pulse_controller im_we_p (.CLK(clk), .sw_input(IM_we), .clk_pulse(IM_we_pulse));    
    pulse_controller rf_p (.CLK(clk), .sw_input(RF_external_load), .clk_pulse(RF_ext_pulse));
    
    
    always_comb begin
        if (ALU_op == 3'b010 | ALU_op == 3'b011) begin
            in3 = RF_d2;
            in2 = RF_d1;
            in1 = 0;
            in0 = ALU_out;
        end
        else if (ALU_op == 3'b111) begin
            in3 = 0;
            in2 = 0;
            in1 = 0;
            in0 = ALU_out;
        end
        else begin
            in3 = 0;
            in2 = 0;
            in1 = 0;
            in0 = 0;
        end
    end
endmodule