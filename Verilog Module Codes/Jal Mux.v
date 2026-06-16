
module jal_mux (
    input [31:0] normal_write_data,
    input [31:0] pc_plus_4,
    input Jal,

    output [31:0] final_write_data
);

assign final_write_data =
       (Jal) ? pc_plus_4
             : normal_write_data;

endmodule