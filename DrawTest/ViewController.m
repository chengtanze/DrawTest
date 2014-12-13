//
//  ViewController.m
//  DrawTest
//
//  Created by wangsl-iMac on 14/11/28.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "ViewController.h"
#import "CircleProgressView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    CALayer * progressBackGrpup = [[CALayer alloc]init];
//    
//    progressBackGrpup.bounds = CGRectMake(0, 0, 250, 100);
//    progressBackGrpup.backgroundColor = [UIColor whiteColor].CGColor;
//    [progressBackGrpup setAnchorPoint:CGPointMake(0, 0)];
//    [progressBackGrpup setPosition:CGPointMake(50, 150)];
//    
//    progressBackGrpup.cornerRadius = 15 / 2.0;
//    progressBackGrpup.delegate = self;
//    
//    [self.view.layer addSublayer:progressBackGrpup];
//    [progressBackGrpup setNeedsDisplay];
    

    
//    CALayer * Progress = [[CALayer alloc]init];
//    
//    Progress.bounds = CGRectMake(0, 0, 100, 15);
//    Progress.backgroundColor = [UIColor yellowColor].CGColor;
//    [Progress setAnchorPoint:CGPointMake(0, 0)];
//    [Progress setPosition:CGPointMake(50, 150)];
//    
//    Progress.cornerRadius = 15 / 2.0;
//    Progress.delegate = self;
    

    //[self.view.layer addSublayer:Progress];
    //[Progress setNeedsDisplay];
    
    
//    
//    CircleProgressView * view = [[CircleProgressView alloc]initWithFrame:CGRectMake(60, 170, 200, 200)];
//    view.radius = 100.0;
//    view.lineWidth = 10.0;
//    [view initCircle];
//    
//    [self.view addSubview:view];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    NSLog(@"drawLayer in Ctrl%@", layer);
    
//    UIGraphicsPushContext(ctx);
//    NSString * stringProgress = @"50/100gfdsfsdfdsfsafsfds";
//    
//    UIColor *stringColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0];  //设置文本的颜色
//    
//    NSDictionary* attrs =@{NSForegroundColorAttributeName:stringColor,NSFontAttributeName:[UIFont fontWithName:@"AmericanTypewriter"size:18],}; //在词典中加入文本的颜色 字体 大小
//    
//    [stringProgress drawAtPoint:CGPointMake(50, 50) withAttributes:attrs];
//    
//    UIGraphicsPopContext();
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
