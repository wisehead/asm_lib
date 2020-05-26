#<center>AT&T汇编语言——简单实例及工具演示</center>

今天就来用具体实例代码来运用一下昨天所说的只个工具的用法吧
这几个实例主要的目的是来熟悉一下汇编相关工具的用法及应用一下昨天刚说的汇编程序模板。

 我们用到的工具主要有as,ld,gcc,gdb,当然，它们是运行在linux系统下的

废话少说，直接来例子了。嗯，再说一句，下面的例子是参考或来自《汇编语言程序设计》Richard Blum的

#例一：打印出"hello,world!"

```asm
#hellowrold.s print "hello,world!"

.section .data
	output:
		.ascii "hello,world\n"

.section .text
.globl _start
_start:
	movl $4, %eax
	movl $1, %ebx
	movl $output,%ecx
	movl $12,%edx
	int  $0x80
	movl $1, %eax
	movl $0, %ebx
	int  $0x80
```

简单说一下代码：

首先，在数据段中声明一个字符串：

```
output:
		.ascii "hello,world\n"
```
.asscii声明使用ASCII字符声明一个文本字符串。字符串元素被预定义并且放在内存中，其起始内存位置由标签output指示。

下面是声明程序的指令码段和一般的起始标签，_start是链接器默认的起始代码：

```
.section .text
.globl _start
_start:
```

下面是直接调用write系统调用来显示文本内容

```
        movl $4, %eax
	movl $1, %ebx
	movl $output,%ecx
	movl $12,%edx
	int  $0x80
```

Linux下write系统调用的参数：
EAX包含系统调用值，write是4

EBX包含要写入的文件描述符，我们知道，Linux终端中0表示标准输入，1表示标准输出，2表示错误输出，这里将1传入EBX,也就是表示标准输出
ECX包含字符串的开头

EDX包含字符串的长度

用样，下面也是系统调用 ，1表示退出函数，返回值为0

```
        movl $1, %eax
	movl $0, %ebx
	int  $0x80
```

编译运行结果如下：
![](res/1)

先解释编译参数，

第一步：首先编译成二进制文件  as --32 -o hellowrold.o hellowrold.s

as表示用as汇编器，

--32表示将目标代码编译成ia-32代码格式
-o hellowrold.o 表示目标文件是hellowrold.o（好像，写错文件名了Orzbubuko.com,布布扣)

hellowrold.s就是源代码了（本来要定成helloworld.s的，错了就错了吧）

第二步:然后，将hellowrold.o链接成可执行文件
ld -m elf_i386 -o hellowrold hellowrold.o 

ld表示是用ld链接

-m elf_i386 表示生成32 elf位 elf格式文件

-o hellowrold表示生成的文件是hellowrold

hellowrold.o 是在第一阶段生成的二进制文件


再来试试gdb这个调试工具，汇编器as的多了个参数 -g，表示生成debug 代码。gdb  hellowrold运行调试，界面如下：

![](res/2)

gdb的用法主要有几个：list显示代码，break设置段点， info register显示所有寄存器的值，print打印特定变量的值，x显示特定内存位置的值，step下一指令，run运行代码。

演示一下：

list,列出代码
![](res/3)

break设置断点，这里是在特定的标签中设置，break有以下方式设置断点：

1.到达某个标签

2.到达源代码中的某个行号

3.数据值到达特定值

4.函数执行了指宝的次数之后


print 打印出相应的值，print 的输出格式有：

print/d 输出十进制值

print/t  输出二进制值
print/x 输出十六进制值
![](res/4)

info register 打印出所有寄存器值
![](res/5)
当然，我们的例子只要改一下，将 代码入口标签_start改成main就可以用gcc来编译。

```
gcc -m32 -o hellowrold hellowrold.s  
```

就可以编译成功了。

#例二、下面再说个在汇编语言中调用c函数库的例子。

```
.section .data
	output:
		.ascii "The number is %d\n"
.section .bss
	.lcomm buffer,18
.section .text
		
.globl _start
_start:
	
	pushl $520
	pushl $output
	call  printf
	addl  $8,%esp
	pushl $0
	call  exit
```

如下方法编译该代码，可以看出，ld链接的时候多了几个参数。
![](res/6)

让我来一一说一下多出来的两个参数的含义吧。

我们知道 ，在linux中，把C函数连接到汇编语言程序有两种方法。第一种中做静态链接（static linking).静态链接把函数目标代码直接连接到应用 程序的可执行程序文件中。这样会创建巨大的可执行程序，而且，如果同时运行程序的多个实例，会造 成内在浪费（每个函数都有其自己的相同函数拷贝)

第二种方法是动态链接。

在Linux中，标准C的动态库位于lib.so.x文件中，在我的系统（ubutnu 14.04 ）中，这个文件是libc.so.6，由于我采用兼容方式运行，所以，我的系统有两个该文件，一个是32位的（/lib/i386-linux-gnu/libc.so.6），还有一个是64位的（/lib/x86_64-linux-gnu/libc.so.6）。在使用gcc时，gcc是自动将c语言链接到该库，我们使用ld，为了链接libc.so文件，必须使用gnu连接器的-l 参数，不用指定完整的库名称。连接器假设在它能找到的位置存在libxso文件，基中x是命令行参数指定的库名称，我们的是c，故使用

> -lc

理论上，我们不用加参数 -dynamic-linker就可以运行了，可事实上，编译是通过了，但是运行不了。

> bash: ./print: No such file or directory

为什么呢？
问题在于连接器是能够解析C函数了，但是函数本身没有包含在最终可执行程序中。链接器假设运行时程序能够找到该库文件，所以编译进不出错。但事实上，我们的程序找不到该库文件。为了解决这个问题，还必须指定在程序运行时加载动态库的程序。对于LINUX，这个程序是linux.so.2,在我的系统下，它位于/lib下。为了指定这个程序，必须使用gnu链接器的 -dynamic-linker,故还要添加参数
> -dynamic-linker

其实，我们也可以直接用 gcc编译，只要把_start标签改成 main就可以如下方法 编译了

```
gcc -o print print.s
```

标签：debug   32位   atampt   汇编语言   调试   

原文：http://blog.csdn.net/crazyboy2009/article/details/33817025
