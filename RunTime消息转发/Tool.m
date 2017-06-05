//
//  Tool.m
//  runtime
//
//  Created by 🍎应俊杰🍎 doublej on 2017/6/5.
//  Copyright © 2017年 doublej. All rights reserved.
//

#import "Tool.h"

@interface Tool ()

@property (nonatomic, assign) NSInteger count;

@end


@implementation Tool

+ (instancetype)sharedManager {
    static Tool *addInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        addInstance = [[Tool alloc] init];
    });
    
    return addInstance;
}

- (void)addCount
{
    _count += 1;
    NSLog(@"总点击%ld次", _count);
}
@end
