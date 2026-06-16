
module immediate_generator (
    input [31:0] instruction,
    output reg [31:0] immediate
);

wire [5:0] opcode;

assign opcode = instruction[31:26];

always @(*) begin

    case (opcode)

        // ADDI
        6'b001000:
            immediate = {{16{instruction[15]}}, instruction[15:0]};

        // LW
        6'b100011:
            immediate = {{16{instruction[15]}}, instruction[15:0]};

        // SW
        6'b101011:
            immediate = {{16{instruction[15]}}, instruction[15:0]};

        // BEQ
        6'b000100:
            immediate = {{16{instruction[15]}}, instruction[15:0]};

        // BNE
        6'b000101:
            immediate = {{16{instruction[15]}}, instruction[15:0]};

        // ANDI
        6'b001100:
            immediate = {16'd0, instruction[15:0]};

        // ORI
        6'b001101:
            immediate = {16'd0, instruction[15:0]};

        default:
            immediate = 32'd0;

    endcase

end

endmodule