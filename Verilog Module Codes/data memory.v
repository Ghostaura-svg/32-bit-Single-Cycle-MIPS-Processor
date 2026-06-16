
module data_memory (
    input clk,
    input reset,
    input MemRead,
    input MemWrite,

    input [31:0] address,
    input [31:0] write_data,

    output reg [31:0] read_data
);

reg [31:0] memory [0:255];

integer i;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        for (i = 0; i < 256; i = i + 1)
            memory[i] <= 32'd0;

        // Initial data for testing
        memory[0] <= 32'd100;
        memory[1] <= 32'd200;
        memory[2] <= 32'd300;
    end
    else begin
        if (MemWrite)
            memory[address[9:2]] <= write_data;
    end
end

always @(*) begin
    if (MemRead)
        read_data = memory[address[9:2]];
    else
        read_data = 32'd0;
end

endmodule