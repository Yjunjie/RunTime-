//
//  ClassB.m
//  RunTime消息转发
//
//  Created by 🍎应俊杰🍎 doublej on 2017/6/5.
//  Copyright © 2017年 doublej. All rights reserved.
//

#import "ClassB.h"
#import <objc/runtime.h>

@implementation ClassB

/*
 方案一：
 
 + (BOOL)resolveInstanceMethod:(SEL)sel
 + (BOOL)resolveClassMethod:(SEL)sel
 
 方案二：
 
 - (id)forwardingTargetForSelector:(SEL)aSelector
 
 方案三：
 
 - (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector;
 - (void)forwardInvocation:(NSInvocation *)anInvocation;
 

 void self _cmd
*  关于生成签名类型"v@:"解释一下, 每个方法会默认隐藏两个参数, self, _cmd
self 代表方法调用者, _cmd 代表这个方法SEL, 签名类型就是用来描述这个方法的返回值, 参数的,
v代表返回值为void, @表示self, :表示_cmd
*/

//类方法转发
+(BOOL)resolveClassMethod:(SEL)sel{
    if (sel == NSSelectorFromString(@"methodClassB")) {
        class_addMethod(objc_getMetaClass("ClassB"), sel, (IMP)methodClassASubstitute, "v@:");
    }else if (sel == NSSelectorFromString(@"methodClassB:")) {
        class_addMethod(objc_getMetaClass("ClassB"), sel, (IMP)methodClassASubstituteParameter, "v@:*");
    }
    return YES;
}

void methodClassASubstitute (id self,SEL sel)
{
    // 程序会走我们C语言的部分
    NSLog(@"类方法methodClassA:%@ %s", self, sel_getName(sel));
}

void methodClassASubstituteParameter(id self, SEL _cmd, NSString *string){
    // 程序会走我们C语言的部分
    NSLog(@"类方法带参转发methodClassASubstituteParameter%@", string);
}

//实例法转发
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    
    if(sel == @selector(methodB)) {
        class_addMethod([self class], sel, (IMP)methodASubstitute, "v@:");
        return YES;
    }else if(sel == @selector(methodB:)) {
        class_addMethod([self class], sel, (IMP)methodASubstituteParameter, "v@:*");
        return YES;
    }else if(sel == @selector(methodC:)) {
        class_addMethod([self class], sel, (IMP)methodASubstituteParameterAddturn, "v@:*");
        return YES;
    }
    return [super respondsToSelector:sel];
}

void methodASubstitute (id self,SEL sel)
{
    // 程序会走我们C语言的部分
    NSLog(@"实例转发methodASubstitute:%@ %s", self, sel_getName(sel));
}

void methodASubstituteParameter(id self, SEL _cmd, NSString *string){
    // 程序会走我们C语言的部分
    NSLog(@"实例带参转发methodASubstituteParameter%@", string);
}

void methodASubstituteParameteraa(id self, SEL _cmd, NSString *string){
    // 程序会走我们C语言的部分
    NSLog(@"实例带参转发methodASubstituteParameter%@", string);
}

NSString * methodASubstituteParameterAddturn(id self, SEL _cmd, NSString *string){
    NSLog(@"实例带参转发带返回参methodASubstituteParameterAddturn%@", string);
    return string;
}

@end
