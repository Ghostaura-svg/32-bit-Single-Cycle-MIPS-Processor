# 32-bit Single-Cycle MIPS Processor Using Verilog

## Project Overview

This project implements a **32-bit Single-Cycle MIPS Processor** using **Verilog Hardware Description Language (HDL)**. The processor follows the classical single-cycle datapath architecture in which every instruction is completed within a single clock cycle. The design integrates both datapath and control path components to support instruction execution, memory access, branching, and jump operations.

The processor was designed as part of the **Computer Architecture Laboratory** course to demonstrate the practical implementation of processor concepts such as instruction fetch, decode, execute, memory access, and write-back stages.

---

## Features

* 32-bit MIPS architecture implementation.
* Single-cycle execution model.
* Modular Verilog design with separate files for each component.
* Support for arithmetic, logical, memory, branch, and jump instructions.
* Integrated control unit and ALU control logic.
* Simulation and verification using ModelSim.
* Testbench designed to trace instruction execution and processor behavior.

---

## Supported Instructions

### R-Type Instructions


### I-Type Instructions


### Memory Instructions


### Branch Instructions


### Jump Instructions

---

## Project Structure

```text
├── alu.v
├── alu_control.v
├── branch_adder.v
├── branch_logic.v
├── control_unit.v
├── data_memory.v
├── destination_register_mux.v
├── immediate_generator.v
├── instruction_memory.v
├── jal_mux.v
├── jump_address_generator.v
├── mux2x1.v
├── pc_adder.v
├── program_counter.v
├── register_file.v
├── mips_single_cycle_processor.v
└── mips_single_cycle_processor_tb.v
```

---

## Processor Components

| Module                   | Function                                         |
| ------------------------ | ------------------------------------------------ |
| Program Counter          | Stores the address of the current instruction    |
| Instruction Memory       | Stores program instructions                      |
| Register File            | Provides register read and write operations      |
| Control Unit             | Generates control signals based on opcode        |
| Immediate Generator      | Extends immediate values for I-type instructions |
| ALU Control              | Determines ALU operation                         |
| ALU                      | Performs arithmetic and logical operations       |
| Data Memory              | Supports load and store instructions             |
| Branch Logic             | Determines branch decisions                      |
| PC Adder                 | Computes `PC + 4`                                |
| Branch Adder             | Computes branch target address                   |
| Jump Address Generator   | Computes jump target address                     |
| Destination Register MUX | Selects the destination register                 |
| JAL MUX                  | Handles return address storage for `jal`         |

---

## Simulation

The processor functionality was verified using **ModelSim**. The testbench displays processor activity cycle by cycle, including:

* Current Program Counter (PC)
* Executing instruction
* Source and destination register values
* ALU results
* Memory read/write activity
* Write-back values
* Zero flag status
* Branch and jump behavior

---

## Sample Execution Flow

```text
1. Fetch instruction from instruction memory.
2. Decode instruction fields and generate control signals.
3. Read operands from the register file.
4. Perform ALU operation.
5. Access data memory if required.
6. Write results back to the register file.
7. Update the Program Counter.
```

---

## Tools Used

* **Verilog HDL**
* **ModelSim**

---

## Learning Outcomes

Through this project, the following concepts were explored and implemented:

* Processor datapath design.
* Control signal generation.
* Instruction execution in a single-cycle architecture.
* Branch and jump handling mechanisms.
* Register file and memory interfacing.
* Hardware verification using simulation techniques.

---

## Author

**Abdul Rehman**
BS Computer Science
Computer Architecture Lab Project
