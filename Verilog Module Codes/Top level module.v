
module mips_single_cycle_processor (
    input clk,
    input reset,

    output [31:0] pc_current_out,
    output [31:0] instruction_out,
    output [31:0] alu_result_out,
    output [31:0] write_data_out,
    output [31:0] memory_read_data_out,

    output Zero_out,
    output Negative_out,
    output Carry_out,
    output Overflow_out
);

wire [31:0] pc_current;
wire [31:0] pc_next;
wire [31:0] pc_plus_4;

wire [31:0] instruction;

wire [5:0] opcode;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire [5:0] funct;
wire [25:0] jump_field;

wire RegDst;
wire ALUSrc;
wire MemtoReg;
wire RegWrite;
wire MemRead;
wire MemWrite;
wire Branch;
wire BranchNE;
wire Jump;
wire Jal;
wire [2:0] ALUOp;

wire [4:0] write_register;

wire [31:0] read_data1;
wire [31:0] read_data2;

wire [31:0] immediate;
wire [31:0] alu_input_B;

wire [3:0] ALUControl;

wire [31:0] alu_result;
wire Zero;
wire Negative;
wire Carry;
wire Overflow;

wire [31:0] memory_read_data;
wire [31:0] normal_write_data;
wire [31:0] final_write_data;

wire [31:0] branch_address;
wire PCSrc;
wire [31:0] pc_after_branch;

wire [31:0] jump_address;

// Instruction field extraction
assign opcode     = instruction[31:26];
assign rs         = instruction[25:21];
assign rt         = instruction[20:16];
assign rd         = instruction[15:11];
assign funct      = instruction[5:0];
assign jump_field = instruction[25:0];

// Program Counter
program_counter PC (
    .clk(clk),
    .reset(reset),
    .pc_next(pc_next),
    .pc_current(pc_current)
);

// Instruction Memory
instruction_memory IM (
    .address(pc_current),
    .instruction(instruction)
);

// PC + 4 Adder
pc_adder PC_ADD (
    .pc_current(pc_current),
    .pc_plus_4(pc_plus_4)
);

// Control Unit
control_unit CU (
    .opcode(opcode),
    .RegDst(RegDst),
    .ALUSrc(ALUSrc),
    .MemtoReg(MemtoReg),
    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .Branch(Branch),
    .BranchNE(BranchNE),
    .Jump(Jump),
    .Jal(Jal),
    .ALUOp(ALUOp)
);

// Destination Register Selection
destination_register_mux DEST_MUX (
    .rt(rt),
    .rd(rd),
    .RegDst(RegDst),
    .Jal(Jal),
    .write_register(write_register)
);

// Register File
register_file RF (
    .clk(clk),
    .reset(reset),
    .RegWrite(RegWrite),
    .read_reg1(rs),
    .read_reg2(rt),
    .write_reg(write_register),
    .write_data(final_write_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

// Immediate Generator
immediate_generator IMM_GEN (
    .instruction(instruction),
    .immediate(immediate)
);

// ALU Source MUX
mux2x1 ALU_SRC_MUX (
    .input0(read_data2),
    .input1(immediate),
    .select(ALUSrc),
    .out(alu_input_B)
);

// ALU Control
alu_control ALU_CTRL (
    .ALUOp(ALUOp),
    .funct(funct),
    .ALUControl(ALUControl)
);

// ALU
alu ALU_UNIT (
    .A(read_data1),
    .B(alu_input_B),
    .ALUControl(ALUControl),
    .Result(alu_result),
    .Zero(Zero),
    .Negative(Negative),
    .Carry(Carry),
    .Overflow(Overflow)
);

// Data Memory
data_memory DM (
    .clk(clk),
    .reset(reset),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .address(alu_result),
    .write_data(read_data2),
    .read_data(memory_read_data)
);

// Write Back MUX
mux2x1 WRITE_BACK_MUX (
    .input0(alu_result),
    .input1(memory_read_data),
    .select(MemtoReg),
    .out(normal_write_data)
);

// JAL Write Back MUX
jal_mux JAL_WRITE_MUX (
    .normal_write_data(normal_write_data),
    .pc_plus_4(pc_plus_4),
    .Jal(Jal),
    .final_write_data(final_write_data)
);

// Branch Address Adder
branch_adder BR_ADD (
    .pc_plus_4(pc_plus_4),
    .immediate(immediate),
    .branch_address(branch_address)
);

// Branch Logic
branch_logic BR_LOGIC (
    .Branch(Branch),
    .BranchNE(BranchNE),
    .Zero(Zero),
    .PCSrc(PCSrc)
);

// Branch PC MUX
mux2x1 BRANCH_PC_MUX (
    .input0(pc_plus_4),
    .input1(branch_address),
    .select(PCSrc),
    .out(pc_after_branch)
);

// Jump Address Generator
jump_address_generator JUMP_GEN (
    .pc_plus_4(pc_plus_4),
    .jump_field(jump_field),
    .jump_address(jump_address)
);

// Jump PC MUX
mux2x1 JUMP_PC_MUX (
    .input0(pc_after_branch),
    .input1(jump_address),
    .select(Jump),
    .out(pc_next)
);

// Outputs for waveform observation
assign pc_current_out        = pc_current;
assign instruction_out       = instruction;
assign alu_result_out        = alu_result;
assign write_data_out        = final_write_data;
assign memory_read_data_out  = memory_read_data;

assign Zero_out     = Zero;
assign Negative_out = Negative;
assign Carry_out    = Carry;
assign Overflow_out = Overflow;

endmodule