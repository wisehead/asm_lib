#############################################################
#   File Name: build.sh
#     Autohor: Hui Chen (c) 2020
#        Mail: chenhui13@baidu.com
# Create Time: 2020/04/25-18:28:28
#############################################################
#!/bin/sh 
gcc -S hello.c
gcc hello.s -o hello

#nm
gcc hello.s -c -o hello.o
nm hello.o
