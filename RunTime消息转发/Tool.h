//
//  Tool.h
//  runtime
//
//  Created by 🍎应俊杰🍎 doublej on 2017/6/5.
//  Copyright © 2017年 doublej. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject

+ (instancetype)sharedManager;

- (void)addCount;
@end
