module mux2to1 (
    input logic[11:0] in1, in0, 
    input logic s,
    output logic [11:0] out
    );
    assign out = s ? in1 : in0;
endmodule