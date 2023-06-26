module control_unit (
    input wire clk, reset, nextinstruction, isexternal, IM_we,
    input wire [11:0] IM_wd,
    output wire DM_we, DM_re, RF_we, loadSignal,
    output wire [2:0] ALU_op,
    output wire [11:0] IM_out
);
    wire[2:0] pc_addr, next_pc_addr;
    wire[11:0] IR_out;
    
    pc pc (clk, reset, next_pc_addr, nextinstruction, pc_addr);
    pc_adder pcadder (pc_addr, next_pc_addr);
    instruction_memory im (clk, reset, pc_addr, IM_wd, IM_we, isexternal, nextinstruction, IM_out);
    instruction_register ir (clk, IM_out, IR_out);
    controller c (clk, IR_out, DM_we, DM_re, RF_we, loadSignal, ALU_op);
endmodule
