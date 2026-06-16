
module alu_control (
    input [2:0] ALUOp,
    input [5:0] funct,
    output reg [3:0] ALUControl
);

always @(*) begin

    case (ALUOp)

        // ADD operation
        // addi, lw, sw
        3'b000:
            ALUControl = 4'b0010;

        // SUB operation
        // beq, bne
        3'b001:
            ALUControl = 4'b0110;

        // R-Type Instructions
        3'b010: begin

            case (funct)

                6'b100000:
                    ALUControl = 4'b0010; // ADD

                6'b100010:
                    ALUControl = 4'b0110; // SUB

                6'b100100:
                    ALUControl = 4'b0000; // AND

                6'b100101:
                    ALUControl = 4'b0001; // OR

                6'b100110:
                    ALUControl = 4'b0011; // XOR

                6'b101010:
                    ALUControl = 4'b0111; // SLT

                6'b100111:
                    ALUControl = 4'b1100; // NOR

                default:
                    ALUControl = 4'b1111;

            endcase
        end

        // ANDI
        3'b011:
            ALUControl = 4'b0000;

        // ORI
        3'b100:
            ALUControl = 4'b0001;

        default:
            ALUControl = 4'b1111;

    endcase

end

endmodule