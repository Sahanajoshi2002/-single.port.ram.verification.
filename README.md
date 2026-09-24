Single-Port RAM Verification using SystemVerilog

Overview
This project implements and verifies a Single-Port RAM using SystemVerilog.
A SystemVerilog-based verification environment is used to generate RAM transactions, drive them to the DUT, monitor the interface activity, and verify the results using a scoreboard.

Verification Components
- Transaction
- Generator
- Driver
- Monitor
- Scoreboard
- Environment
- RAM Interface
- RAM Testbench
- Single-Port RAM (DUT)

Architecture
Generator
    |
Transaction
    |
  Driver
    |
RAM Interface
    |
Single-Port RAM (DUT)
    |
  Monitor
    |
Scoreboard

Operations Verified
- RAM write operation
- RAM read operation
- Address handling
- Data write and read
- Expected vs actual data comparison
- Functional checking using scoreboard

Technologies
- SystemVerilog
- Simulation-based functional verification
- Single-Port RAM

Project Structure
Single-Port-RAM-Verification/
├── ram.sv
├── ram_if.sv
├── transaction.sv
├── generator.sv
├── driver.sv
├── monitor.sv
├── scoreboard.sv
├── environment.sv
└── ram_tb.sv

Key Learning
This project helped me understand and implement a SystemVerilog-based verification environment, including transaction modeling, stimulus generation, DUT driving, monitoring, environment construction, and scoreboard-based functional checking.
