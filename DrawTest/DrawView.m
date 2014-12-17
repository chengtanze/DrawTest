//
//  DrawView.m
//  DrawTest
//
//  Created by wangsl-iMac on 14/11/28.
//  Copyright (c) 2014年 chengtz-iMac. All rights reserved.
//

#import "DrawView.h"

#define PI (3.14159f)

@implementation DrawView
 //Only override drawRect: if you perform custom drawing.
 //An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    //[self drawAngle:270 endAngle:45];
    //[self drawAngle:0 endAngle:360];
    
    //[self drawLine:CGPointMake(0, 100) end:CGPointMake(100, 100)];
    //[self drawLine:CGPointMake(100, 100) radius:50 withAngle:45];
    //CGPoint pointArray[5] = {{100, 100}, {150, 150}, {100, 200}, {50, 150}, {100, 100}};
    //[self drawLine:pointArray numberOfPoint:5];
    //[self drawRectangle:CGRectMake(60,170,200,50)];
    //[self drawRoundedRect:CGRectMake(60,170,200,50)];
    //[self drawRectByBezier:CGRectMake(60,170,200,50)];
    
    //[self drawPointByBezier];
    
    //[self drawArcByBezier];
    [self drawQuadCurveBezier];
    [self drawCubicCurveBezier];
    //[self draweCircle:CGRectMake(60,170,80,80)];
    
    //[self drawArcRect];
    //[self drawText:@"1231"];
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
    CGContextSetLineWidth(context, 1.0);
    CGContextBeginPath(context);
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextAddArc(context, 100, 100, 50, startAngle * PI / 180, endAngle * PI / 180, 0);
    CGContextStrokePath(context);
}

//画直线
-(void)drawLine:(CGPoint)start end:(CGPoint)end
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    //设置线宽
    CGContextSetLineWidth(context, 5.0);
    //设置颜色
    //CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    //设置起点
    CGContextMoveToPoint(context, start.x, start.y);
    //添加路径
    CGContextAddLineToPoint(context, end.x, end.y);
    

    //绘制
    CGContextStrokePath(context);
}

//画带角度的直线
-(void)drawLine:(CGPoint)start radius:(CGFloat)radius withAngle:(float)angle
{
    /*
     sinA = 对边 / 斜边
     cosA = 邻边 / 斜边
     */
    CGPoint point;
    float radian = 0.0;
    if (angle >= 0 && angle <= 90) {
        radian = angle * PI / 180;
        //NSLog(@"sinAngle = %f, cosAngle = %f", sin(angle), cos(angle));
        point.x = start.x + radius * cos(radian);
        point.y = start.y + radius * sin(radian);
    }
    else if (angle > 90 && angle <= 180){
        radian = (angle - 90)* PI / 180;
        point.x = start.x - radius * sin(radian);
        point.y = start.y + radius * cos(radian);
    }else if (angle > 180 && angle <= 270){
        radian = (angle - 180)* PI / 180;
        point.x = start.x - radius * cos(radian);
        point.y = start.y - radius * sin(radian);
    }else{
        radian = (angle - 270)* PI / 180;
        point.x = start.x + radius * sin(radian);
        point.y = start.y - radius * cos(radian);
    }
    
    [self drawLine:start end:point];
}

//根据坐标数据绘制图形
-(void)drawLine:(CGPoint[])pointArray numberOfPoint:(long)count
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    
    for (long nIndex = 0; nIndex < count; nIndex++) {
        if (nIndex == 0) {
            CGContextMoveToPoint(context, pointArray[nIndex].x, pointArray[nIndex].y);
        }
    
        CGContextAddLineToPoint(context, pointArray[nIndex].x, pointArray[nIndex].y);
        
        //NSLog(@"x :%f, y:%f", pointArray[nIndex].x, pointArray[nIndex].y);
    }
    //指定填充颜色
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    //填充指定的路径
    CGContextFillPath(context);
    
    CGContextStrokePath(context);
    
}

//绘制矩形
-(void)drawRectangle:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineJoin(context, kCGLineJoinRound);
    //指定路径颜色
    CGContextSetLineWidth(context, 2.0);
    
    //指定填充颜色
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    //填充矩形区域
    CGContextFillRect(context, rect);
    
    CGContextAddRect(context, rect);
    
    
    //CGContextDrawPath(context, kCGPathStroke);
    CGContextStrokePath(context);
}

//绘制椭圆或是圆形
-(void)draweCircle:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //指定路径颜色
    CGContextSetLineWidth(context, 2.0);
    
    //指定填充颜色
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    //填充圆形
    CGContextFillEllipseInRect(context, rect);
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextStrokePath(context);
}

-(void)drawArcRect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context,0,0,1,1.0);//画笔线的颜色
    CGContextSetLineWidth(context, 1.0);//线的宽度
    //    /*画圆角矩形*/
        float fw = 200;
        float fh = 280;
    CGContextMoveToPoint(context, fw, fh-20);  // 开始坐标右边开始
    CGContextAddArcToPoint(context, fw, fh, fw-20, fh, 10);  // 右下角角度
    CGContextAddArcToPoint(context, 120, fh, 120, fh-20, 10); // 左下角角度
    CGContextAddArcToPoint(context, 120, 250, fw-20, 250, 10); // 左上角
    CGContextAddArcToPoint(context, fw, 250, fw, fh-20, 10); // 右上角
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
}

-(void)drawText:(NSString *)string{
    
    
    UIColor *stringColor = [UIColor colorWithRed:0.5f green:0.0f blue:0.5f alpha:1.0];  //设置文本的颜色
    
    NSDictionary* attrs =@{NSForegroundColorAttributeName:stringColor,
                           NSFontAttributeName:[UIFont fontWithName:@"AmericanTypewriter"size:18],
                           }; //在词典中加入文本的颜色 字体 大小
    
    [string drawInRect:CGRectMake(0, 0, 80, 15) withAttributes:attrs];
}

-(void)drawRoundedRect:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    
    CGContextSetLineWidth(ctx, 3);
    
    UIBezierPath *path;
    
    path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 100, 100) byRoundingCorners:(UIRectCornerAllCorners) cornerRadii:CGSizeMake(100, 100)];
    
    //[path stroke];
    [path fill];
}

-(void)drawRectByBezier:(CGRect)rect{
    
    UIBezierPath * path;
    
    path = [UIBezierPath bezierPathWithRect:rect];
    
    //线条拐角
    path.lineCapStyle = kCGLineCapRound;
    //线条连接点
    path.lineJoinStyle = kCGLineJoinRound;
    //线宽
    path.lineWidth = 2.0;
    
    UIColor * color = [UIColor redColor];
    [color set];
    
    [path stroke];
}

-(void)drawPointByBezier{
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(100, 100)];
    
    [path addLineToPoint:CGPointMake(150, 100)];
    [path addLineToPoint:CGPointMake(150, 150)];
    
    //线条拐角
    path.lineCapStyle = kCGLineCapRound;
    //线条连接点
    path.lineJoinStyle = kCGLineJoinRound;
    //线宽
    path.lineWidth = 2.0;
    
    UIColor * color = [UIColor redColor];
    [color set];
    
    
    [path stroke];
}

-(void)drawArcByBezier{
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:50 startAngle:0 endAngle:M_PI_2 clockwise:YES];
    
    //线条拐角
    path.lineCapStyle = kCGLineCapRound;
    //线条连接点
    path.lineJoinStyle = kCGLineJoinRound;
    //线宽
    path.lineWidth = 2.0;
    
    UIColor * color = [UIColor redColor];
    [color set];
    
    [path stroke];
    
    

}

-(void)drawQuadCurveBezier{
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(150, 150)];
    
    [path addQuadCurveToPoint:CGPointMake(200, 200) controlPoint:CGPointMake(170, 0)];
    
    UIColor * color = [UIColor yellowColor];
    [color setStroke];
    
    //线条拐角
    path.lineCapStyle = kCGLineCapRound;
    //线条连接点
    path.lineJoinStyle = kCGLineJoinRound;
    //线宽
    path.lineWidth = 2.0;
    
    [path stroke];
    
}

-(void)drawCubicCurveBezier{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(150, 150)];
    
    [path addCurveToPoint:CGPointMake(300, 200) controlPoint1:CGPointMake(170, 100) controlPoint2:CGPointMake(250, 220)];
    
    UIColor * color = [UIColor yellowColor];
    [color setStroke];
    
    //线条拐角
    path.lineCapStyle = kCGLineCapRound;
    //线条连接点
    path.lineJoinStyle = kCGLineJoinRound;
    //线宽
    path.lineWidth = 2.0;
    
    [path stroke];
}

@end
