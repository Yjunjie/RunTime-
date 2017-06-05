//
//  UIImage+Image.m
//  RunTime消息转发
//
//  Created by 🍎应俊杰🍎 doublej on 2017/6/5.
//  Copyright © 2017年 doublej. All rights reserved.
//

#import "UIImage+Image.h"
#import <objc/runtime.h>

@implementation UIImage (Image)

// 加载分类到内存的时候调用
+ (void)load
{
//    类方法交换方法
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 获取imageWithName方法地址
        Method imageWithName = class_getClassMethod(self, @selector(imageWithName:));
        // 获取imageWithName方法地址
        Method imageName = class_getClassMethod(self, @selector(imageNamed:));
        // 交换方法地址，相当于交换实现方式
        method_exchangeImplementations(imageWithName, imageName);
    });
}

// 不能在分类中重写系统方法imageNamed，因为会把系统的功能给覆盖掉，而且分类中不能调用super.
+ (instancetype)imageWithName:(NSString *)name
{
    NSLog(@"imageWithName");
    // 这里调用imageWithName，相当于调用imageName
    UIImage *image = [self imageWithName:name];
    if (image == nil) {
        NSLog(@"error:图片为空，请检查是否存在此图或重新导入");
    }
    return image;
}

@end
