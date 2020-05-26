#############################################################
#   File Name: build.sh
#     Autohor: Hui Chen (c) 2020
#        Mail: chenhui13@baidu.com
# Create Time: 2020/04/25-18:48:01
#############################################################
#!/bin/sh 
#below command doesn't work
#gcc -o hello hello.s
#as --32 -o hello.o hello.s
#ld -m elf_i386 -o hello hello.o
gcc -m32 -o hello hello.s  
