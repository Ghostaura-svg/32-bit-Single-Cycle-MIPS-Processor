
module jump_address_generator (
    input [31:0] pc_plus_4,
    input [25:0] jump_field,
    output [31:0] jump_address
);

assign jump_address =
{
    pc_plus_4[31:28],
    jump_field,
    2'b00
};

endmodule