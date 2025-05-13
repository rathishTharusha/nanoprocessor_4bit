# 4-Bit Nanoprocessor

Welcome to the 4-Bit Nanoprocessor project! This repository contains the design and implementation of a simple 4-bit microprocessor capable of executing a basic instruction set. The processor is implemented in VHDL and designed to run on the Basys3 FPGA board using Xilinx Vivado. This project is ideal for educational purposes, demonstrating fundamental concepts of computer architecture and digital design.

## Table of Contents
- [Project Overview](#project-overview)
- [Features](#features)
- [Repository Structure](#repository-structure)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Project Overview
The 4-Bit Nanoprocessor is a minimalistic processor designed to execute a small set of instructions. It includes core components such as registers, an arithmetic logic unit (ALU), decoders, multiplexers, and a program ROM. The processor supports basic operations like data movement, arithmetic, and conditional jumps, with results displayable on the Basys3 FPGA's 7-segment display.

This project was developed as part of a computer architecture course and serves as a practical introduction to processor design and FPGA programming.

## Features
- **4-Bit Architecture**: Processes 4-bit data and instructions.
- **Instruction Set**: Supports instructions such as:
  - `MOV`: Move data between registers.
  - `ADD`: Add two numbers.
  - `NEG`: Negate a number.
  - `JZR`: Jump if zero.
- **FPGA Implementation**: Designed for the Basys3 FPGA board.
- **Components**:
  - 4-bit registers for data storage.
  - ALU for addition and subtraction (2’s complement).
  - Program ROM with hardcoded instructions.
  - 7-segment display output for results.
- **Simulation Support**: Includes scripts for testing and simulation in Xilinx Vivado.

## Repository Structure
```
nanoprocessor_4bit/
├── src/                    # VHDL source files for processor components
│   ├── register_4bit.vhd   # 4-bit register implementation
│   ├── alu.vhd             # Arithmetic logic unit
│   ├── rom.vhd             # Program ROM with instructions
│   ├── nanoprocessor.vhd   # Top-level processor design
│   └── ...
├── sim/                    # Simulation scripts and testbenches
│   ├── tb_nanoprocessor.vhd # Testbench for processor
│   └── ...
├── constraints/            # FPGA constraint files
│   ├── basys3.xdc          # Pin mappings for Basys3 board
├── docs/                   # Documentation and reports
│   ├── timing_diagram.pdf  # Simulation timing diagram
│   └── ...
├── README.md               # This file
└── LICENSE                 # License file
```

## Requirements
- **Hardware**:
  - Basys3 FPGA board (or compatible FPGA).
- **Software**:
  - Xilinx Vivado Design Suite (2020.2 or later recommended).
  - Git for cloning the repository.
- **Operating System**: Windows, Linux, or macOS.

## Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/rathishTharusha/nanoprocessor_4bit.git
   cd nanoprocessor_4bit
   ```
2. **Install Xilinx Vivado**:
   - Download and install Vivado from the [Xilinx website](https://www.xilinx.com/products/design-tools/vivado.html).
   - Ensure the Basys3 board is supported in your Vivado installation.
3. **Set Up the Project**:
   - Open Vivado and create a new project.
   - Add the VHDL files from the `src/` directory to the project.
   - Include the constraint file (`constraints/basys3.xdc`) for pin mappings.

## Usage
1. **Simulation**:
   - Open Vivado and load the testbench (`sim/tb_nanoprocessor.vhd`).
   - Run the simulation to verify the processor's functionality.
   - Check the timing diagram in `docs/timing_diagram.pdf` for expected behavior.
2. **Synthesis and Implementation**:
   - Synthesize the design in Vivado.
   - Implement the design and generate the bitstream (`.bit` file).
3. **FPGA Deployment**:
   - Connect the Basys3 FPGA board to your computer.
   - Program the FPGA with the generated bitstream using Vivado's Hardware Manager.
   - The sample program (e.g., adding integers 1+2+3=6) will run, and the result will display on the 7-segment display.
4. **Modifying Instructions**:
   - Edit the `rom.vhd` file to change the hardcoded instructions in the program ROM.
   - Re-synthesize and reprogram the FPGA to test new programs.

## Contributing
We welcome contributions to enhance the nanoprocessor! To contribute:
1. **Fork the Repository**:
   - Create a fork of this repository on GitHub.
2. **Create a Branch**:
   - Use a descriptive branch name, e.g., `feature/new-instruction`.
   ```bash
   git checkout -b feature/new-instruction
   ```
3. **Make Changes**:
   - Add new features, fix bugs, or improve documentation.
   - Ensure your code follows VHDL coding standards and is well-commented.
4. **Test Your Changes**:
   - Run simulations to verify functionality.
   - Test on the Basys3 FPGA if possible.
5. **Submit a Pull Request**:
   - Push your changes to your fork and create a pull request.
   - Provide a clear description of your changes and their purpose.
6. **Code Review**:
   - Respond to feedback and make necessary updates.

Please adhere to the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/version/2/0/code_of_conduct/).

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
