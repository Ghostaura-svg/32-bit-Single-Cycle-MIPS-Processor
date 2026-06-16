
module destination_register_mux (
    input [4:0] rt,
    input [4:0] rd,
    input RegDst,
    input Jal,

    output [4:0] write_register
);

assign write_register =
       (Jal) ? 5'd31 :
       (RegDst ? rd : rt);

endmodule