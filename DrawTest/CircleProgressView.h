//
//  CircleProgressView.h
//  DrawTest
//
//  Created by cheng on 14/12/1.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleProgressView : UIView
{
    
    CGPoint currPoint;
    CGFloat currAngle;
}

-(void)initCircle;

@property(nonatomic) CGPoint centerPoint;
@property(nonatomic) CGFloat radius;
@property(nonatomic) CGFloat lineWidth;
@end
