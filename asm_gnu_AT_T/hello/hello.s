.section .rodata
hello:
  .asciz "Hello, world"        # 定义打印字符串,存放在数据段中，ro表示只读；

format:
  .asciz "%s\n"                # 定义打印格式字符串，存放在数据段中；


.section .text                 # 代码段定义main函数。
.globl main
main:
  pushl $hello                 # push第二个参数到栈中
  pushl $format                # push第一个参数到栈中
  call printf                  # 调用printf("%s\n", &hello)
  addl $8, %esp

  pushl $0
  call exit                    # 调用exit(0)
