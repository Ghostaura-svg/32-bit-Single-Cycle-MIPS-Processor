
module register_file (
    input clk,
    input reset,
    input RegWrite,

    input [4:0] read_reg1,
    input [4:0] read_reg2,
    input [4:0] write_reg,

    input [31:0] write_data,

    output [31:0] read_data1,
    output [31:0] read_data2
);

reg [31:0] registers [31:0];

integer i;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        for (i = 0; i < 32; i = i + 1)
            registers[i] <= 32'd0;

        // Initial values for testing
        registers[1] <= 32'd20;
        registers[2] <= 32'd20;
    end
    else begin
        if (RegWrite && write_reg != 5'd0)
            registers[write_reg] <= write_data;
    end
end

assign read_data1 = registers[read_reg1];
assign read_data2 = registers[read_reg2];

endmodule