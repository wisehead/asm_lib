.section .data
    output:
        .ascii "The number is %d\n"
.section .bss
    .lcomm buffer,18
.section .text
        
.globl main 
main:
    
    pushl $520
    pushl $output
    call  printf
    addl  $8,%esp
    pushl $0
    call  exit
