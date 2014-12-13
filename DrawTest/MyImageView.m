
//
//  MyImageView.m
//  DrawTest
//
//  Created by wangsl-iMac on 14/12/12.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "MyImageView.h"
#import <math.h>
@implementation MyImageView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIImage * image = [UIImage imageNamed:@"test2"];
    
    [image drawAtPoint:CGPointMake(100, 100)];
    
    //加载出来的图片锚点默认在左上角
    
    //通过CGContextDrawImage加载的图片默认是反的，需要翻转
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //将context移动到（0， 400）的位置
    CGContextTranslateCTM(context, 0, 280);
    
    //通过设置y轴负方向来翻转图片 (这样会把整个layer旋转过来，坐标系也回跟着旋转。必须要保存之前的状态，才不会影响其他的显示)
    CGContextScaleCTM(context, 1, -1);
    
    
    CGContextTranslateCTM(context, 0, -119);
    //CGContextRotateCTM(context, -M_PI_4);

    //通过翻转和平移才能画出正常的图片
    CGContextDrawImage(context, CGRectMake(0, 0, 163, 119), image.CGImage);
    
    
}


@end
