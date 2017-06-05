//
//  UIButton+count.m
//  runtime
//
//  Created by 🍎应俊杰🍎 doublej on 2017/6/5.
//  Copyright © 2017年 doublej. All rights reserved.
//

#import "UIButton+count.h"
#import "Tool.h"
@implementation UIButton (count)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selA = @selector(sendAction:to:forEvent:);
        Method methodA = class_getInstanceMethod(self, selA);
        SEL selB = @selector(custSendAction:to:forEvent:);
        Method methodB = class_getInstanceMethod(self, selB);
        BOOL addSucc = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
        if (addSucc) {
            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
        }else {
            method_exchangeImplementations(methodA, methodB);
        }
    });
}

- (void)custSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [self custSendAction:action to:target forEvent:event];
}

@end
