module datapath (
    input wire clk, reset,
    input wire[11:0] instr,
    input wire DM_we, DM_re, RF_we, loadSignal, RF_external_load,
    input wire [2:0] ALU_op, external_WA,
    input wire [3:0] external_WD,
    output wire [3:0] RF_d1, RF_d2, ALU_out
);
    
    wire [3:0] DM_rd, RF_WD_Mux_Out;
    wire [2:0] RF_WA_Mux_Out;
    wire [11:0] shiftedInstr, shiftmux_out;
    
    srl1 srl (instr, shiftedInstr);
    mux2to1 shiftmux (shiftedInstr, instr, loadSignal, shiftmux_out);
    mux4to1#(3) RF_WA_Mux (external_WA, external_WA, instr[6:4], instr[11:9], RF_external_load, loadSignal, RF_WA_Mux_Out);
    mux4to1#(4) RF_WD_Mux (external_WD, external_WD, DM_rd, ALU_out, RF_external_load, loadSignal, RF_WD_Mux_Out);
    register_file rf (clk, reset, shiftmux_out[2:0], shiftmux_out[5:3], RF_WA_Mux_Out, RF_WD_Mux_Out, RF_we, RF_external_load, RF_d1, RF_d2);
    alu alu (RF_d1, RF_d2, ALU_op, ALU_out);
    data_memory dm(clk, reset, instr[3:0], RF_d2, DM_we, DM_re, DM_rd);
endmodule