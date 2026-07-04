# Memory Design and Verification Project

## Overview
This project implements and verifies a [type of memory — e.g., synchronous dual-port RAM] 
using Verilog. It includes the RTL design, a self-checking testbench, and simulation 
results demonstrating correct read/write functionality.

## Features
- [e.g., Configurable memory depth and width]
- [e.g., Synchronous read/write operations]
- [e.g., Separate read and write data ports]
- Functional verification using a custom testbench

## Tools Used
- **Design Language:** Verilog
- **Simulation Tools:** ModelSim / QuestaSim
- **Waveform Analysis:** QuestaSim waveform viewer

## Folder Structure

Memory-Project/
├── src/          # RTL design and testbench files
│   ├── memory.v
│   └── memory_tb.v
├── sim/          # Simulation scripts and test data
│   ├── run.do
│   ├── log_run.do
│   ├── wave.do
│   ├── read_data_mem.bin
│   └── write_data_mem.hex
├── results/      # Simulation outputs
│   ├── transcript
│   ├── vsim.wlf
│   ├── diag.pdf
│   ├── wave_form.pdf
│   └── wave_form_2.pdf
├── docs/         # Project theory and explanation
│   └── Theory.txt
└── lib/          # Auto-generated simulation library files

## How to Run the Simulation
1. Open ModelSim/QuestaSim
2. Navigate to the `sim/` folder
3. Run the simulation script:

do run.do
4. View waveforms using:
do wave.do
5. Simulation logs and transcripts will be generated in the `results/` folder

## Verification Approach
The testbench (`memory_tb.v`) applies read and write operations to the memory module 
and checks the output against expected values loaded from `write_data_mem.hex` and 
`read_data_mem.bin`. Waveforms and simulation transcripts confirm correct functional 
behavior.

## Results
- [e.g., Successfully verified read/write operations across all memory addresses]
- Waveform outputs are available in `results/wave_form.pdf` and `results/wave_form_2.pdf`
- Detailed theory and design explanation available in `docs/Theory.txt`

## Author
Architha Kanchanapally  
[LinkedIn](https://www.linkedin.com/in/archithakanchanapally) | archithakanchanapally@gmail.com

