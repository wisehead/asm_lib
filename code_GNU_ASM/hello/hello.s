.section .rodata
hello:
  .asciz "Hello, world"        # �����ӡ�ַ���,��������ݶ��У�ro��ʾֻ����

format:
  .asciz "%s\n"                # �����ӡ��ʽ�ַ�������������ݶ��У�


.section .text                 # ����ζ���main������
.globl main
main:
  pushl $hello                 # push�ڶ���������ջ��
  pushl $format                # push��һ��������ջ��
  call printf                  # ����printf("%s\n", &hello)
  addl $8, %esp

  pushl $0
  call exit                    # ����exit(0)
