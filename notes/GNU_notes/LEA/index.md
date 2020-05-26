---
title: (1条消息)ATT汇编指令中mov与lea的作用比较_嵌入式_独钓寒江雪-CSDN博客
category: default
tags: 
  - blog.csdn.net
created_at: 2020-05-26 16:29:59
original_url: https://blog.csdn.net/qq_21049875/article/details/81219132
---

# ATT汇编指令中mov与lea的作用比较

![](assets/1590481799-f79882c200644842455bdaffffa12b14.png)  

[Rookie\_2020](https://me.csdn.net/qq_21049875) 2018-07-26 14:11:15 ![](assets/1590481799-4b4b8d4273e2a4c6a7e1dab33d22e30a.png) 1656 ![](assets/1590481799-d5e50e4ae956617ae79565ca116f0649.png) 收藏  2 

展开

  以下是个人的感觉，不太确定对错，但是测试过好像是这样。  
  之前挺好奇mov和lea有什么区别，说是一个是传值一个传地址，的确好像是这样。  
  `mov`的源操作数和目标操作数，其中目标操作数不能是立即数，且源操作数与目标操作数不能同时是存储器（内存地址）。  
  `lea`的源操作数**只能是有效地址**，目标操作数**只能是寄存器**。  
  两者在操作一些内存地址上意思好像是一样的。  
  比如`0x8151abc`是一个函数的地址，我们想把它存入`%ebp`中，则可以这样：

```
mov  $0x8151abc,%ebp 
lea  0x8151abc,%ebp
```

  第一个的意思是把立即数存入`%ebp`中，作为`%ebp`的值。  
  第二个的意思是把地址存入`%ebp`中，作为`%ebp`的值，两者并无差别。  
  但是当`mov`的源操作数是地址的时候：

```
mov  0x8151abc,%ebp  
或者 
mov 0x28(%esp),%ebp
```

  意思就变了，变成从这个地址中找到存储的值传送到`%ebp`中。  
  所以，综合上面可知道lea其实就是mov的一种形式。  
  而且`lea`指令可以加载`有效地址`也可以理解源操作数是寄存器存储的值，即：

```
int func(int x,int y){
return x+2*y+2;

}
%rdi为x，%rsi为y  
则: 
lea 0x2(%rdi,%rsi,2),%rax //eax=x+2y+2
```

  以上的使用比起mov来说方便一些，其实还是得看所使用的寄存器主要用来做什么，要是上面的例子中参数为指针的话：

```
int func(int *x,int *y){ 
return *x+(*y)*2+2
}
mov (%rsi),%rax  //rax= *y;
lea 0x2(%rax,%rax),%rax //rax=2*rax+2
add (%rdi),%rax //rax=rax+*x
```

  则不能直接用lea，因为这样会得到的是指针x与指针y地址的合+2，这时候用mov倒是比较方便，先从指针指向的地址中获取值，然后用lea去计算，再用add.  
  所以，到底是使用lea或者mov，得看情况，看寄存器的用途去使用吧。

---------------------------------------------------


原网址: [访问](https://blog.csdn.net/qq_21049875/article/details/81219132)

创建于: 2020-05-26 16:29:59

目录: default

标签: `blog.csdn.net`

