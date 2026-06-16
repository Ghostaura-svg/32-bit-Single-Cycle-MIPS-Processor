
module control_unit (
    input [5:0] opcode,

    output reg RegDst,
    output reg ALUSrc,
    output reg MemtoReg,
    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg Branch,
    output reg BranchNE,
    output reg Jump,
    output reg Jal,

    output reg [2:0] ALUOp
);

always @(*) begin

    RegDst   = 0;
    ALUSrc   = 0;
    MemtoReg = 0;
    RegWrite = 0;
    MemRead  = 0;
    MemWrite = 0;
    Branch   = 0;
    BranchNE = 0;
    Jump     = 0;
    Jal      = 0;
    ALUOp    = 3'b000;

    case (opcode)

        6'b000000: begin
            // R-type
            RegDst   = 1;
            RegWrite = 1;
            ALUOp    = 3'b010;
        end

        6'b001000: begin
            // ADDI
            ALUSrc   = 1;
            RegWrite = 1;
            ALUOp    = 3'b000;
        end

        6'b001100: begin
            // ANDI
            ALUSrc   = 1;
            RegWrite = 1;
            ALUOp    = 3'b011;
        end

        6'b001101: begin
            // ORI
            ALUSrc   = 1;
            RegWrite = 1;
            ALUOp    = 3'b100;
        end

        6'b100011: begin
            // LW
            ALUSrc   = 1;
            MemtoReg = 1;
            RegWrite = 1;
            MemRead  = 1;
            ALUOp    = 3'b000;
        end

        6'b101011: begin
            // SW
            ALUSrc   = 1;
            MemWrite = 1;
            ALUOp    = 3'b000;
        end

        6'b000100: begin
            // BEQ
            Branch = 1;
            ALUOp  = 3'b001;
        end

        6'b000101: begin
            // BNE
            BranchNE = 1;
            ALUOp    = 3'b001;
        end

        6'b000010: begin
            // J
            Jump = 1;
        end

        6'b000011: begin
            // JAL
            Jump     = 1;
            Jal      = 1;
            RegWrite = 1;
        end

        default: begin
            RegDst   = 0;
            ALUSrc   = 0;
            MemtoReg = 0;
            RegWrite = 0;
            MemRead  = 0;
            MemWrite = 0;
            Branch   = 0;
            BranchNE = 0;
            Jump     = 0;
            Jal      = 0;
            ALUOp    = 3'b000;
        end

    endcase

end

endmodule