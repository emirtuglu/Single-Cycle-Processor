module srl1 (
    input logic[11:0] in,
    output logic[11:0] out
    );
    assign out = in>>1;
endmodule