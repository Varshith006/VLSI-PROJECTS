# Reversible ALU Project (alu_db)

## 📌 Overview
This project implements a **reversible Arithmetic Logic Unit (ALU)** in Verilog using reversible logic gates like Peres, Toffoli, Fredkin, TR, and DKG.  
The design supports **arithmetic, logical, decoding, multiplexing, multiplication, and storage operations**, and is verified through simulation and synthesis.

## 🛠 Features
- **Arithmetic Operations**
  - Addition (Full Adder using Peres gates)
  - Subtraction (DKG-based Subtractor)
  - 2-bit Multiplication (Peres + Half Adder)
- **Logical Operations**
  - AND, OR, NOT, XOR, XNOR, NAND, NOR
- **Other Functional Units**
  - 2:1 Storage Element (Fredkin gate)
  - 4:1 Multiplexer (using MF gates)
  - 2-to-4 Decoder (Peres, TR, CNOT based)
- Fully **reversible design** → no information loss.

## 🖼 Schematic
The structural schematic of the ALU is shown below:

![ALU Schematic](alu_schematic.png)

*(You can replace `alu_schematic.png` with the uploaded image file.)*

## ▶️ Simulation
- **Testbench**: `alu_db_tb.v` provided to verify correctness.
- Tested in **ModelSim / Vivado / Icarus Verilog**.
- Example output signals:
  - Adder: `Sum`, `Carry`
  - Subtractor: `Diff`, `Bout`
  - Multiplier: `Product[3:0]`
  - Decoder: `Decoder_Y[3:0]`
  - Storage: `Storing`
  - Logic gates: `AND, OR, NOT, XOR, XNOR, NAND, NOR`

## 📂 Project Structure
