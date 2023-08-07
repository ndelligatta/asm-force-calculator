# Hybrid Assembly Force Calculator

Welcome to the Hybrid Assembly Force Calculator project! This repository showcases a powerful hybrid programming approach that combines Assembly and C to check your clock speed (GHz) and compute the tics/ns required to calculate the required braking force with M/v/freq.

## About

This project demonstrates the synergy of Assembly and C programming languages in the realm of force calculations. It leverages the following components:

- **Assembly (`force.asm` and `clock_speed.asm`):** The Assembly code handles intricate braking force computations and measures your clock's frequency in GHz.

- **C (`driver.c`):** The C driver program masterfully orchestrates the functionality of the calculator. It seamlessly integrates Assembly components, manages input/output, and ensures an intuitive user experience.

## Usage

To harness the power of the Hybrid Assembly Force Calculator:

1. Ensure that the necessary toolchains are installed (NASM and GCC).
2. Open your terminal or command prompt.
3. Navigate to the project directory.
4. Execute the provided script `r.sh` to assemble, compile, and link the program:

   ```bash
   ./r.sh
Run the generated my.out executable to launch the calculator:

    ./my.out
    
Follow the on-screen instructions to input the required parameters and unveil the calculated braking force.

## Contents
force.asm: Assembly code for intricate braking force calculations.
clock_speed.asm: Assembly code for measuring your clock's frequency in GHz.
driver.c: C driver program that masterfully coordinates the calculator's hybrid functionality.
r.sh: Bash script for seamlessly assembling, compiling, and linking the hybrid program.
force.lis: Assembly listing file for force.asm.
clock_speed.lis: Assembly listing file for clock_speed.asm.

## Notes
This project exemplifies a remarkable hybrid assembly programming approach.
It expertly calculates the required braking force using Assembly and C synergy.
The calculator provides invaluable insights into tics/ns for the force calculation and accurately measures your clock's frequency.
Feel free to delve into the code, absorb the hybrid assembly-C harmony, and adapt the program to enhance your own projects.
