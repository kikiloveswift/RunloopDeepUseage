//
//  SymbolicTest.m
//  RunloopDeepUseage
//
//  Created by konglee on 2017/10/28.
//  Copyright © 2017年 konglee. All rights reserved.
//   宏定义测试

#import "SymbolicTest.h"

//#的用处是字符串化操作符
#define pstr(str) printf("the string is:%s\n",#str)

//##的用处是符号连接操作符
#define com(n) printf("a"#n "= %d",a##n)

@implementation SymbolicTest

+ (void)test
{
    pstr("ass");
    int a10 = 9;
    com(10);
}

@end
