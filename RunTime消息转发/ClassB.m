//
//  ClassB.m
//  RunTime消息转发
//
//  Created by 🍎应俊杰🍎 doublej on 2017/6/5.
//  Copyright © 2017年 doublej. All rights reserved.
//

#import "ClassB.h"
#import <objc/runtime.h>
#import "ClassA.h"
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

//方案一
//类方法动态添加方法
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

//动态添加方法
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
    NSLog(@"实例methodASubstitute:%@ %s", self, sel_getName(sel));
}

void methodASubstituteParameter(id self, SEL _cmd, NSString *string){
    // 程序会走我们C语言的部分
    NSLog(@"实例带参methodASubstituteParameter%@", string);
}

NSString * methodASubstituteParameterAddturn(id self, SEL _cmd, NSString *string){
    NSLog(@"实例带参带返回参methodASubstituteParameterAddturn%@", string);
    return string;
}

//方案二：
//快速转发
//现在不对方案一做任何的处理, 直接调用父类的方法, 系统会走到forwardingTargetForSelector方法
//- (id) forwardingTargetForSelector:(SEL)aSelector
//{
//    return [[ClassA alloc] init];
//}

/**
 *  方案三
 *  慢速转发路径:runtime发送methodSignatureForSelector:消息,查看Selector对应的方法签名.如果有方法签名返回，runtime则根据方法签名创建描述该消息的NSInvocation，向当前对象发送forwardInvocation:消息，以创建的NSInvocation对象作为参数；若methodSignatureForSelector:无方法签名返回，则向当前对象发送doesNotRecognizeSelector:消息,程序抛出异常退出。
 所以我们需要做的是自己新建方法签名，再在forwardInvocation中用你要转发的那个对象调用这个对应的签名，这样也实现了消息转发。
 */

//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
//{
//    NSString *sel = NSStringFromSelector(aSelector);
//    // 判断转发的SEL
//    if ([sel isEqualToString:@"methodB"]) {
//        // 为你的转发方法手动生成签名
//        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//    }
//    return [super methodSignatureForSelector:aSelector];
//}
//
//-(void)forwardInvocation:(NSInvocation *)anInvocation
//{
//    SEL selector = [anInvocation selector];
//    // 新建转发消息的对象
//    ClassA *classA = [[ClassA alloc] init];
//    if ([classA respondsToSelector:selector]) {
//    // 唤醒这个方法
//        [anInvocation invokeWithTarget:classA];
//    }
//}
@end
