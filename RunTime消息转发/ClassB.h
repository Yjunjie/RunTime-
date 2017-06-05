//
//  ClassB.h
//  RunTime消息转发
//
//  Created by 🍎应俊杰🍎 doublej on 2017/6/5.
//  Copyright © 2017年 doublej. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassB : NSObject

-(void)methodA;
+(void)methodClassA;

-(void)methodB;
-(void)methodB:(NSString*)tagString;
-(NSString*)methodC:(NSString*)tagString;

+(void)methodClassB;
+(void)methodClassB:(NSString*)tagString;

@end
