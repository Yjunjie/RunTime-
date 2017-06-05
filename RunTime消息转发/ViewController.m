//
//  ViewController.m
//  RunTime消息转发
//
//  Created by 🍎应俊杰🍎 doublej on 2017/6/5.
//  Copyright © 2017年 doublej. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Image.h"
#import <objc/runtime.h>
#import "UIButton+count.h"
#import "ClassB.h"
#import "ClassA.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //本地图片 图片名写错了加载会有提示
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    imgView.backgroundColor = [UIColor grayColor];
    imgView.image = [UIImage imageNamed:@"没有这张图"];
    [self.view addSubview:imgView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(100, 230, 100, 100);
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];


    ClassB *per = [[ClassB alloc] init];
    //实例方法转发
    [per methodB];
    //实例方法带参转发
    [per methodB:@"实例方法带参转发"];
    //实例带参转发带返回参
    NSString *str = [per methodC:@"实例带参转发带返回参"];
    NSLog(@"str==%@",str);
    //类方法转发
    [ClassB methodClassB];
    //类方法带参转发
    [per methodB:@"类方法带参转发"];
    
    
}

- (void)ButtonClick
{
    NSLog(@"按钮被点击了");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
