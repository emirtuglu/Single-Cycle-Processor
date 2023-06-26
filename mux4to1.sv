module mux4to1 #(parameter WIDTH = 1) (
    input logic [WIDTH-1:0] in3, in2, in1, in0,
    input logic s1, s0,
    output logic [WIDTH-1:0] out
    );
    assign out = s1 ? (s0 ? in3 : in2) : (s0 ? in1 : in0);
endmodule