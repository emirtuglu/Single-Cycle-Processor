module pc_adder(
    input wire[2:0] pc,
    output wire[2:0] next_pc
);
    assign next_pc = pc + 1;
endmodule