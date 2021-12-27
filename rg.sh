#!/bin/bash
## =============================================== ##
## Nolan Delligatta                                ##
## CPSC 240-03                                     ##
## ndelligatta@csu.fullerton.edu                   ##
## Force Calculator                                ##
## =============================================== ##

rm *.o
rm *.out

echo "Welcome to the bash script"

echo "Assemble force.asm"
nasm -f elf64 -l force.lis -o force.o force.asm -g -gdwarf

echo "Assemble clock_speed.asm"
nasm -f elf64 -l clock_speed.lis -o clock_speed.o clock_speed.asm -g -gdwarf

echo "Compile the C main function"
gcc -c -Wall -o driver.o -m64 -no-pie -fno-pie driver.c -g

echo "Link 3 object files"
gcc -m64 driver.o force.o clock_speed.o -fno-pie -no-pie -o my.out -g

gdb ./my.out

echo "===terminated==="