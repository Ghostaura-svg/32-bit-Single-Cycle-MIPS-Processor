
module branch_adder (
    input [31:0] pc_plus_4,
    input [31:0] immediate,
    output [31:0] branch_address
);

assign branch_address = pc_plus_4 + (immediate << 2);

endmodule