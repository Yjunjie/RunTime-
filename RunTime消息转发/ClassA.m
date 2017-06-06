//
//  ClassA.m
//  RunTime消息转发
//
//  Created by 🍎应俊杰🍎 doublej on 2017/6/5.
//  Copyright © 2017年 doublej. All rights reserved.
//

#import "ClassA.h"
#import <objc/runtime.h>

@implementation ClassA

-(void)methodB{
    NSLog(@"ClassA.h---methodB");
}

void addMethodClassA(id self,SEL sel)
{
    NSLog(@"没有实现classAmethaed转发添加调用了addMethodClassA方法");
}

//动态添加方法
//默认一个方法都有两个参数，self，_cmd,为隐式参数，不显示
//self ：方法的调用者
//_cmd ：调用方法的编号，即方法名

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(classAmethaed)) {
        // 动态添加eat方法
        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        SEL classAmethaed = @selector(classAmethaed);
        class_addMethod(self, classAmethaed, (IMP)addMethodClassA, "v@:");
    }
    return [super resolveInstanceMethod:sel];
}
@end
