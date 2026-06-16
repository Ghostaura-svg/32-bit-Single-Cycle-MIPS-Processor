
module alu (
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALUControl,

    output reg [31:0] Result,
    output Zero,
    output Negative,
    output reg Carry,
    output reg Overflow
);

reg [32:0] temp;

always @(*) begin

    Result = 32'd0;
    Carry = 1'b0;
    Overflow = 1'b0;
    temp = 33'd0;

    case (ALUControl)

        4'b0000: begin
            // AND
            Result = A & B;
        end

        4'b0001: begin
            // OR
            Result = A | B;
        end

        4'b0010: begin
            // ADD
            temp = {1'b0, A} + {1'b0, B};
            Result = temp[31:0];
            Carry = temp[32];

            Overflow = (~A[31] & ~B[31] & Result[31]) |
                       ( A[31] &  B[31] & ~Result[31]);
        end

        4'b0011: begin
            // XOR
            Result = A ^ B;
        end

        4'b0110: begin
            // SUB
            temp = {1'b0, A} - {1'b0, B};
            Result = temp[31:0];
            Carry = temp[32];

            Overflow = (~A[31] & B[31] & Result[31]) |
                       ( A[31] & ~B[31] & ~Result[31]);
        end

        4'b0111: begin
            // SLT signed comparison
            if ($signed(A) < $signed(B))
                Result = 32'd1;
            else
                Result = 32'd0;
        end

        4'b1100: begin
            // NOR
            Result = ~(A | B);
        end

        default: begin
            Result = 32'd0;
        end

    endcase

end

assign Zero = (Result == 32'd0);
assign Negative = Result[31];

endmodule