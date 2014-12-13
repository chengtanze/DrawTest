//
//  CircleProgressView.m
//  DrawTest
//
//  Created by cheng on 14/12/1.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "CircleProgressView.h"

@implementation CircleProgressView

#define PI (3.14159f)
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //[self initCircle];
    };
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //[self initCircle];
    }
    return self;
}

-(void)initCircle
{
   
    self.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self addGestureRecognizer:tapGesture];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self addGestureRecognizer:panGesture];
    
    currAngle = 0;
    //
    
    //self.radius -= self.lineWidth / 2.0;
    self.centerPoint = CGPointMake(self.radius, self.radius);
    
    //
}


- (void)handleGesture:(UIGestureRecognizer *)recognizer{
    //NSLog(@"handleGesture");
    
    [self getAngleFromPoint:[recognizer locationInView:self] otherPoint:CGPointMake(self.radius, 0.0)];
}

-(CGFloat)getAngleFromPoint:(CGPoint)point1 otherPoint:(CGPoint)point2
{
    NSLog(@"point x:%f, y:%f", point1.x, point1.y);
    float a = sqrt((point1.x - point2.x) * (point1.x - point2.x) + (point1.y - point2.y) * (point1.y - point2.y));
    
    float c = sqrt((_centerPoint.x - point1.x) * (_centerPoint.x - point1.x) + (_centerPoint.y - point1.y) * (_centerPoint.y - point1.y));
    
    float b = self.radius * 1.0 ;
    
    CGFloat pointAngle = acos( (b * b + c * c - a * a) * 1.0 / (2 * b * c) * 1.0);
    
    currAngle = pointAngle * 180 / M_PI;

    if (point1.x < _centerPoint.x) {
        currAngle = 2 * M_PI - currAngle;
    }
   
    currAngle -= 90;
    [self setNeedsDisplay];
    
    return 0.0;
}

- (void)drawRect:(CGRect)rect {
    [self draweCircle:CGRectMake(0, 0, self.radius * 2, self.radius * 2)];
    [self drawAngle:270.0 endAngle:currAngle];
}

//-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
//    NSLog(@"drawLayer");
//}

//绘制椭圆或是圆形
-(void)draweCircle:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //指定路径颜色
    CGContextSetLineWidth(context, self.lineWidth);
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    //指定填充颜色
    //CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    //填充圆形
    //CGContextFillEllipseInRect(context, rect);
    
    CGRect rectNew =  CGRectMake(rect.origin.x+ self.lineWidth / 2.0
                                   , rect.origin.y + self.lineWidth / 2.0 , rect.size.height - self.lineWidth , rect.size.width - self.lineWidth);
    
    CGContextAddEllipseInRect(context, rectNew);
    
    CGContextStrokePath(context);
}

//画角度
-(void)drawAngle:(float)startAngle endAngle:(float)endAngle
{
    /*
     void CGContextAddArc(CGContextRef c, CGFloat x, CGFloat y, CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise)
     *x,y为圆点坐标，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
     弧度 = 角度 * PI / 180
     角度 = 弧度 * 180 / PI
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextBeginPath(context);
    //CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextAddArc(context, self.centerPoint.x, self.centerPoint.y, self.radius - self.lineWidth / 2.0, startAngle * PI / 180, endAngle * PI / 180, 0);
    CGContextStrokePath(context);
}


@end
