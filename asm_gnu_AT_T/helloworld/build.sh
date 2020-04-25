#############################################################
#   File Name: build.sh
#     Autohor: Hui Chen (c) 2020
#        Mail: chenhui13@baidu.com
# Create Time: 2020/04/25-19:06:54
#############################################################
#!/bin/sh 
as --32 -g -o helloworld.o helloworld.s
ld -m elf_i386 -o helloworld helloworld.o 
