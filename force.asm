;; =============================================== ;;
;; Nolan Delligatta                                ;;
;; CPSC 240-03                                     ;;
;; ndelligatta@csu.fullerton.edu                   ;;
;; Force Calculator                                ;;
;; =============================================== ;;

;================================ Begin code area =====================================================


extern fgets
extern stdin
extern printf
extern strlen
extern atof
extern clock_speed
global force

segment .data
; ==== Lines to be printed for I/O communication ====
ln0 db " ", 10, 0
ln1 db "Welcome to the Nolan Braking Program.", 10, 0
ln2 db "The frequency (GHz) of the processor in machine is %.2lf", 10, 0
ln3 db "Please enter the mass of a moving vehicle (Kg): ", 0
ln4 db "Please enter the velocity of the vehicle (meters per second): ", 0
ln5 db "Please enter the distance (meters) required for a complete stop: ", 0
ln6 db "The required braking force is %lf Newtons", 10, 0
ln7 db "The computation required %ld tics or %.1lf nanosec.", 10, 0
ask db "Please enter the cpu frequency (GHz): ", 0

; half variable = 1/2
hlf dq 0.5


segment .bss
; ==== To be used to store inputs ====
mas resb 32 ; Mass variable
vel resb 32 ; Velocity variable
dis resb 32 ; Distance variable
frq resb 32 ; Optional - to be used if freq not found

segment .text
force:
; ==== Register backup ====
push     rbp
mov      rbp, rsp
push     rbx
push     rcx
push     rdx
push     rdi
push     rsi
push     r8
push     r9
push     r10
push     r11
push     r12
push     r13
push     r14
push     r15
pushf

; ==== Print a blank line ====
push     qword 0
mov      rax, 0
mov      rdi, ln0
call     printf
pop      rax


; ==== Print first line ====
push     qword 0
mov      rax, 0
mov      rdi, ln1
call     printf
pop      rax


; ==== Print second line ====
; Get frequency to print
call     clock_speed
movsd    xmm15, xmm0

; Print current frequency
push     qword 0
push     qword -1
mov      rax, 1
mov      rdi, ln2
movsd    xmm0, xmm15
call     printf
pop      rax
pop      rax


; ==== Print third line ====
push     qword 0
mov      rax, 0
mov      rdi, ln3
call     printf
pop      rax

; Get mass input from user
mov      rdi, mas
mov      rsi, 32
mov      rdx, [stdin]
call     fgets

; Strip trailing white-space out of input
mov      rdi, mas
call     strlen
mov      r14, rax
mov      r15, 0
mov      [mas + r14 - 1], r15

; Convert mass input to float
; xmm12 = mass
mov      rdi, mas
call     atof
movsd    xmm12, xmm0


; ==== Print fourth line ====
push     qword 0
mov      rax, 0
mov      rdi, ln4
call     printf
pop      rax

; Get velocity input from user
mov      rdi, vel
mov      rsi, 32
mov      rdx, [stdin]
call     fgets

; Strip trailing white-space out of input
mov      rdi, vel
call     strlen
mov      r14, rax
mov      r15, 0
mov      [vel + r14 - 1], r15

; Convert velocity input to float
; xmm13 = velocity
mov      rdi, vel
call     atof
movsd    xmm13, xmm0


; ==== Print fifth line ====
push     qword 0
mov      rax, 0
mov      rdi, ln5
call     printf
pop      rax

; Get distance input from user
mov      rdi, dis
mov      rsi, 32
mov      rdx, [stdin]
call     fgets

; Strip trailing white-space out of input
mov      rdi, dis
call     strlen
mov      r14, rax
mov      r15, 0
mov      [dis + r14 - 1], r15

; Convert velocity input to float
; xmm14 = distance
mov      rdi, dis
call     atof
movsd    xmm14, xmm0


; ==== Get tics ====
; Clear registers before storing tics
xor      rax, rax
xor      rdx, rdx
xor      r14, r14

; Take snapshot of current tics
cpuid
rdtsc

; Shift rdx 32 bits to the left, then add it to rax to achieve tic measure
shl      rdx, 32
add      rax, rdx

; Move result into safe register r14
mov      r14, rax


; ==== Perform mathematial calculation ====
; F = (0.5 * m * v * v) / d
; xmm11 = 0.5
; xmm12 = mass
; xmm13 = velocity
; xmm14 = distance

; Insert 0.5 into xmm11
movsd    xmm11, qword[hlf]

; Perform 0.5 * mass
mulsd    xmm12, xmm11

; Perform velocity * velocity
mulsd    xmm13, xmm13

; Perform (0.5 * mass * velocity * velocity)
mulsd    xmm13, xmm12

; Divide the result by distance
divsd    xmm13, xmm14


; ==== Get tics ====
; Clear registers before storing tics
xor      rax, rax
xor      rdx, rdx
xor      r15, r15

; Take snapshot of current tics
cpuid
rdtsc

; Shift rdx 32 bits to the left, then add it to rax to achieve tic measure
shl      rdx, 32
add      rax, rdx

; Move result into safe register r14
mov      r15, rax


; ==== Print sixth line ====
push     qword 0
push     qword -1
mov      rax, 1
mov      rdi, ln6
movsd    xmm0, xmm13
call     printf
pop      rax
pop      rax


; ==== Optional prompt if frequency not found ====
; Compare freq register to 0
xorpd    xmm5, xmm5
ucomisd  xmm15, xmm5
jne next

; Print line asking for frequency input
push     qword 0
push     qword -1
mov      rax, 0
mov      rdi, ask
call     printf
pop      rax
pop      rax

; Get frequency input from user
mov      rdi, frq
mov      rsi, 32
mov      rdx, [stdin]
call     fgets

; Strip trailing white-space out of input
mov      rdi, frq
call     strlen
mov      r10, rax
mov      r11, 0
mov      [frq + r10 - 1], r11

; Convert velocity input to float
; xmm15 = frequency
mov      rdi, frq
call     atof
movsd    xmm15, xmm0

 
next:
; ==== Print seventh line ====
; Subtract tics
; r15 = elapsed tics
sub      r15, r14

; Convert elapsed tics to float and divide xmm10/xmm15
cvtsi2sd xmm10, r15
divsd    xmm10, xmm15

; Print line showing elapsted tics and elapsed nanoseconds
push     qword 0
push     qword -1
mov      rax, 1
mov      rdi, ln7
mov      rsi, r15
movsd    xmm0, xmm10
call     printf
pop      rax
pop      rax


movsd    xmm0, xmm10

finish:
; ==== Register restoration ====
popf
pop      r15
pop      r14
pop      r13
pop      r12
pop      r11
pop      r10
pop      r9
pop      r8
pop      rsi
pop      rdi
pop      rdx
pop      rcx
pop      rbx
pop      rbp

ret
