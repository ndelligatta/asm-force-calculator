#!/bin/bash
## =============================================== ##
## Nolan Delligatta                                ##
## CPSC 240-03                                     ##
## ndelligatta@csu.fullerton.edu                   ##
## Force Calculator                                ##
## =============================================== ##
nasm -f elf64 -l force.lis -o force.o force.asm
nasm -f elf64 -l clock_speed.lis -o clock_speed.o clock_speed.asm
gcc -c -Wall -o driver.o -m64 -no-pie -fno-pie driver.c 
gcc -m64 driver.o force.o clock_speed.o -fno-pie -no-pie -o my.out 
./my.out