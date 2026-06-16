module mips_single_cycle_processor_tb;

reg clk;
reg reset;
integer cycle;

wire [31:0] pc_current_out;
wire [31:0] instruction_out;
wire [31:0] alu_result_out;
wire [31:0] write_data_out;
wire [31:0] memory_read_data_out;

wire Zero_out;
wire Negative_out;
wire Carry_out;
wire Overflow_out;

mips_single_cycle_processor uut (
    .clk(clk),
    .reset(reset),
    .pc_current_out(pc_current_out),
    .instruction_out(instruction_out),
    .alu_result_out(alu_result_out),
    .write_data_out(write_data_out),
    .memory_read_data_out(memory_read_data_out),
    .Zero_out(Zero_out),
    .Negative_out(Negative_out),
    .Carry_out(Carry_out),
    .Overflow_out(Overflow_out)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    cycle = 0;
    reset = 1;

    #10;
    reset = 0;

    #160;
    $stop;
end

always @(posedge clk) begin
    #1;
    cycle = cycle + 1;

    case (pc_current_out)

        32'd0:
            $display("Cycle=%0d | PC=%0d | add  $3,$1,$2  | $1=%0d $2=%0d -> $3=%0d | ALU=%0d | WB=%0d | MemData=%0d | Zero=%b",
                cycle, pc_current_out, uut.RF.registers[1], uut.RF.registers[2], uut.RF.registers[3],
                alu_result_out, write_data_out, memory_read_data_out, Zero_out);

        32'd4:
            $display("Cycle=%0d | PC=%0d | sub  $4,$3,$2  | $3=%0d $2=%0d -> $4=%0d | ALU=%0d | WB=%0d | MemData=%0d | Zero=%b",
                cycle, pc_current_out, uut.RF.registers[3], uut.RF.registers[2], uut.RF.registers[4],
                alu_result_out, write_data_out, memory_read_data_out, Zero_out);

        32'd8:
            $display("Cycle=%0d | PC=%0d | and  $5,$1,$2  | $1=%0d $2=%0d -> $5=%0d | ALU=%0d | WB=%0d | MemData=%0d | Zero=%b",
                cycle, pc_current_out, uut.RF.registers[1], uut.RF.registers[2], uut.RF.registers[5],
                alu_result_out, write_data_out, memory_read_data_out, Zero_out);

        32'd12:
            $display("Cycle=%0d | PC=%0d | or   $6,$1,$2  | $1=%0d $2=%0d -> $6=%0d | ALU=%0d | WB=%0d | MemData=%0d | Zero=%b",
                cycle, pc_current_out, uut.RF.registers[1], uut.RF.registers[2], uut.RF.registers[6],
                alu_result_out, write_data_out, memory_read_data_out, Zero_out);

        32'd16:
            $display("Cycle=%0d | PC=%0d | xor  $7,$1,$2  | $1=%0d $2=%0d -> $7=%0d | ALU=%0d | WB=%0d | MemData=%0d | Zero=%b",
                cycle, pc_current_out, uut.RF.registers[1], uut.RF.registers[2], uut.RF.registers[7],
                alu_result_out, write_data_out, memory_read_data_out, Zero_out);

        32'd20:
            $display("Cycle=%0d | PC=%0d | slt  $8,$1,$2  | $1=%0d $2=%0d -> $8=%0d | ALU=%0d | WB=%0d | MemData=%0d | Zero=%b",
                cycle, pc_current_out, uut.RF.registers[1], uut.RF.registers[2], uut.RF.registers[8],
                alu_result_out, write_data_out, memory_read_data_out, Zero_out);

        32'd24:
            $display("Cycle=%0d | PC=%0d | nor  $9,$1,$2  | $1=%0d $2=%0d -> $9=%0d | ALU=%0d | WB=%0d | MemData=%0d | Zero=%b",
                cycle, pc_current_out, uut.RF.registers[1], uut.RF.registers[2], uut.RF.registers[9],
                alu_result_out, write_data_out, memory_read_data_out, Zero_out);

        32'd28:
            $display("Cycle=%0d | PC=%0d | addi $10,$1,5 | $1=%0d imm=5 -> $10=%0d | ALU=%0d | WB=%0d | MemData=%0d | Zero=%b",
                cycle, pc_current_out, uut.RF.registers[1], uut.RF.registers[10],
                alu_result_out, write_data_out, memory_read_data_out, Zero_out);

        32'd32:
            $display("Cycle=%0d | PC=%0d | andi $11,$1,15 | $1=%0d imm=15 -> $11=%0d | ALU=%0d | WB=%0d | MemData=%0d | Zero=%b",
                cycle, pc_current_out, uut.RF.registers[1], uut.RF.registers[11],
                alu_result_out, write_data_out, memory_read_data_out, Zero_out);

        32'd36:
            $display("Cycle=%0d | PC=%0d | ori  $12,$1,3 | $1=%0d imm=3 -> $12=%0d | ALU=%0d | WB=%0d | MemData=%0d | Zero=%b",
                cycle, pc_current_out, uut.RF.registers[1], uut.RF.registers[12],
                alu_result_out, write_data_out, memory_read_data_out, Zero_out);

        32'd40:
            $display("Cycle=%0d | PC=%0d | lw   $13,0($0) | Mem[0]=%0d -> $13=%0d | ALU=%0d | WB=%0d | MemData=%0d | Zero=%b",
                cycle, pc_current_out, uut.DM.memory[0], uut.RF.registers[13],
                alu_result_out, write_data_out, memory_read_data_out, Zero_out);

        32'd44:
            $display("Cycle=%0d | PC=%0d | sw   $13,4($0) | $13=%0d -> Mem[1]=%0d | ALU=%0d | WB=%0d | MemData=%0d | Zero=%b",
                cycle, pc_current_out, uut.RF.registers[13], uut.DM.memory[1],
                alu_result_out, write_data_out, memory_read_data_out, Zero_out);

        32'd48:
            $display("Cycle=%0d | PC=%0d | beq  $1,$2,2 | $1=%0d $2=%0d | Zero=%b | Branch Taken if Zero=1 | ALU=%0d",
                cycle, pc_current_out, uut.RF.registers[1], uut.RF.registers[2],
                Zero_out, alu_result_out);

        32'd52:
            $display("Cycle=%0d | PC=%0d | bne  $1,$2,2 | $1=%0d $2=%0d | Zero=%b | Branch Taken if Zero=0 | ALU=%0d",
                cycle, pc_current_out, uut.RF.registers[1], uut.RF.registers[2],
                Zero_out, alu_result_out);

        32'd56:
            $display("Cycle=%0d | PC=%0d | j memory[16] | Jump to PC=64 | ALU=%0d | WB=%0d | MemData=%0d | Zero=%b",
                cycle, pc_current_out, alu_result_out, write_data_out, memory_read_data_out, Zero_out);

        32'd60:
            $display("Cycle=%0d | PC=%0d | jal memory[16] | $31=%0d | WB=%0d | Jump to PC=64 | Zero=%b",
                cycle, pc_current_out, uut.RF.registers[31], write_data_out, Zero_out);

        32'd64:
            $display("Cycle=%0d | PC=%0d | add  $14,$1,$2 | $1=%0d $2=%0d -> $14=%0d | ALU=%0d | WB=%0d | MemData=%0d | Zero=%b",
                cycle, pc_current_out, uut.RF.registers[1], uut.RF.registers[2], uut.RF.registers[14],
                alu_result_out, write_data_out, memory_read_data_out, Zero_out);

        32'd68:
            $display("Cycle=%0d | PC=%0d | sub  $15,$14,$2 | $14=%0d $2=%0d -> $15=%0d | ALU=%0d | WB=%0d | MemData=%0d | Zero=%b",
                cycle, pc_current_out, uut.RF.registers[14], uut.RF.registers[2], uut.RF.registers[15],
                alu_result_out, write_data_out, memory_read_data_out, Zero_out);

        32'd72:
            $display("Cycle=%0d | PC=%0d | j memory[18] | Stop loop here | ALU=%0d | WB=%0d | MemData=%0d | Zero=%b",
                cycle, pc_current_out, alu_result_out, write_data_out, memory_read_data_out, Zero_out);

        default:
            $display("Cycle=%0d | PC=%0d | Unknown/Empty Instruction | ALU=%0d | WB=%0d | MemData=%0d | Zero=%b",
                cycle, pc_current_out, alu_result_out, write_data_out, memory_read_data_out, Zero_out);

    endcase
end

endmodule