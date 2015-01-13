//
//  CircProgressBarView.m
//  DrawTest
//
//  Created by cheng on 15/1/11.
//  Copyright (c) 2015年 chengtz-iMac. All rights reserved.
//
#import <math.h>
#import "CircProgressBarView.h"


#define CIRCPRO_START_DOWN_POINT 10.0
#define CIRCPRO_END_DOWN_POINT   170.0

#define CIRCPRO_START_UP_POINT 190.0
#define CIRCPRO_END_UP_POINT   350.0

@interface CircProgressBarView()
{
    //CGFloat downScal;
    CGFloat downCurAngle;
    CGFloat upCurAngle;
    
    CGFloat drawDownCurAngle;
    CGFloat drawUpCurAngle;
}
@property(nonatomic)CGFloat downCurProgress;
@property(nonatomic)CGFloat downMaxProgress;
@property(nonatomic)CGFloat upCurProgress;
@property(nonatomic)CGFloat upDownProgress;
@property (nonatomic, strong)CAShapeLayer *ShapeLayer;
@property (nonatomic, strong)UIView * viewUpBall;
@property (nonatomic, strong)UIView * viewDownBall;
@end

@implementation CircProgressBarView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //[self initCircle];
        self.backgroundColor = [UIColor whiteColor];
        drawDownCurAngle = CIRCPRO_START_DOWN_POINT;
        drawUpCurAngle = CIRCPRO_START_UP_POINT;
        
        self.viewUpBall = [[UIView alloc]initWithFrame:CGRectMake(250, 250, 20, 20)];
        self.viewUpBall.backgroundColor = [UIColor blueColor];
        self.viewUpBall.layer.cornerRadius = 20 / 2.0;
        self.viewUpBall.layer.masksToBounds = YES;
        [self addSubview:self.viewUpBall];
        
        self.viewDownBall = [[UIView alloc]initWithFrame:CGRectMake(250, 250, 20, 20)];
        self.viewDownBall.backgroundColor = [UIColor blueColor];
        self.viewDownBall.layer.cornerRadius = 20 / 2.0;
        self.viewDownBall.layer.masksToBounds = YES;
        [self addSubview:self.viewDownBall];
        
        self.ShapeLayer = [CAShapeLayer layer];
        self.ShapeLayer.lineCap = kCALineCapRound;
        self.ShapeLayer.lineJoin = kCALineJoinBevel;
        self.ShapeLayer.fillColor   = [[UIColor clearColor] CGColor];
        self.ShapeLayer.lineWidth   = 5.0;
        self.ShapeLayer.strokeEnd   = 0.0;
        self.ShapeLayer.strokeColor   = [UIColor greenColor].CGColor;
        [self.layer addSublayer:self.ShapeLayer];
    };
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        downCurAngle = 10;
    }
    return self;
}
BOOL maxValue;

//timer调用函数
-(void)timerFired:(NSTimer *)timer{
    
    
    static BOOL bret = NO;
    if (bret == NO) {
        maxValue = (downCurAngle - drawDownCurAngle) >= (upCurAngle - drawUpCurAngle);
        bret = YES;
    }
    

    
    
    if (maxValue == YES && drawDownCurAngle <= downCurAngle) {
        drawDownCurAngle += 4;
        
        if(drawUpCurAngle <= upCurAngle)
            drawUpCurAngle += 4;
        
        [self setNeedsDisplay];
    }
    else if (maxValue == NO && drawUpCurAngle <= upCurAngle){
        drawUpCurAngle += 4;
        
        if(drawDownCurAngle <= downCurAngle)
            drawDownCurAngle += 4;
        
        [self setNeedsDisplay];
    }

    else{
        [timer invalidate];
        drawDownCurAngle = CIRCPRO_START_DOWN_POINT;
        drawUpCurAngle = CIRCPRO_START_UP_POINT;
    }
}

-(void)setCurrentProgress:(CGFloat)curProgress MaxProgress:(CGFloat)maxProgress{
    self.downCurProgress = curProgress;
    self.downMaxProgress = maxProgress;
    downCurAngle = curProgress / maxProgress  * CIRCPRO_END_DOWN_POINT;
    
    upCurAngle = 20.0 / maxProgress  * (CIRCPRO_END_UP_POINT - CIRCPRO_START_UP_POINT) + CIRCPRO_START_UP_POINT;
    
    NSTimer* connectionTimer=[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [connectionTimer fire];
    
    return;
    
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:100 startAngle:10.0 * M_PI / 180.0 endAngle:80.0 * M_PI / 180.0 clockwise:YES];
    self.ShapeLayer.path = path.CGPath;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    [self.ShapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    
    //该路径最后显示的样子，从0-1全部显示。如果是 start = 1，end = 1表示画完动画后消失
    self.ShapeLayer.strokeStart = 0;
    self.ShapeLayer.strokeEnd = 1;
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(150, 100, 10, 10)];
    view.layer.cornerRadius = 10 / 2;
    
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor yellowColor];
    
    //1.创建核心动画
    CAKeyframeAnimation *keyAnima=[CAKeyframeAnimation animation];
    //平移
    keyAnima.keyPath=@"position";
    //1.1告诉系统要执行什么动画
    //创建一条路径
    //CGMutablePathRef path = CGPathCreateMutable();
    //设置一个圆的路径
    //CGPathAddEllipseInRect(path, NULL, CGRectMake(150, 100, 100, 100));
    keyAnima.path=path.CGPath;
    
    //有create就一定要有release
    //CGPathRelease(path);
    //1.2设置动画执行完毕后，不删除动画
    keyAnima.removedOnCompletion=NO;
    //1.3设置保存动画的最新状态
    keyAnima.fillMode=kCAFillModeForwards;
    //1.4设置动画执行的时间
    keyAnima.duration=1;
    //1.5设置动画的节奏
    keyAnima.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //设置代理，开始—结束
    keyAnima.delegate=self;
    //2.添加核心动画
    [view.layer addAnimation:keyAnima forKey:nil];
    
    [self addSubview:view];
    
}

//画角度
-(void)drawAngle:(float)startAngle endAngle:(float)endAngle Color:(UIColor *)color
{
    /*
     void CGContextAddArc(CGContextRef c, CGFloat x, CGFloat y, CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise)
     *x,y为圆点坐标，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
     弧度 = 角度 * PI / 180
     角度 = 弧度 * 180 / PI
     */
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextBeginPath(context);
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextAddArc(context, 150, 150, 100, startAngle * M_PI / 180, endAngle * M_PI / 180, 0);
    CGContextStrokePath(context);
}

-(void)drawDownBallOnCir:(CGPoint)start radius:(CGFloat)radius withAngle:(float)angle{
    CGPoint point = [self getPointOnCir:start radius:radius withAngle:angle];
    
    self.viewDownBall.center = point;
}

-(void)drawUpBallOnCir:(CGPoint)start radius:(CGFloat)radius withAngle:(float)angle{
    CGPoint point = [self getPointOnCir:start radius:radius withAngle:angle];
    
    self.viewUpBall.center = point;
}

//画带角度的直线
-(CGPoint)getPointOnCir:(CGPoint)start radius:(CGFloat)radius withAngle:(float)angle
{
    CGPoint point;
    float radian = 0.0;
    if (angle >= 0.0 && angle <= 90.0) {
        radian = angle * M_PI / 180.0;
        point.x = start.x + radius * cos(radian);
        point.y = start.y + radius * sin(radian);
    }
    else if (angle > 90.0 && angle <= 180.0){
        radian = (angle - 90.0)* M_PI / 180.0;
        point.x = start.x - radius * sin(radian);
        point.y = start.y + radius * cos(radian);
    }else if (angle > 180.0 && angle <= 270.0){
        radian = (angle - 180.0)* M_PI / 180.0;
        point.x = start.x - radius * cos(radian);
        point.y = start.y - radius * sin(radian);
    }else{
        radian = (angle - 270.0)* M_PI / 180.0;
        point.x = start.x + radius * sin(radian);
        point.y = start.y - radius * cos(radian);
    }
    
    return point;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawAngle:CIRCPRO_START_DOWN_POINT endAngle:CIRCPRO_END_DOWN_POINT Color:[UIColor redColor]];

    [self drawAngle:CIRCPRO_START_DOWN_POINT endAngle:drawDownCurAngle Color:[UIColor blueColor]];
    
    [self drawDownBallOnCir:CGPointMake(150, 150) radius:100 withAngle:drawDownCurAngle];
    
    
    [self drawAngle:CIRCPRO_START_UP_POINT endAngle:CIRCPRO_END_UP_POINT Color:[UIColor redColor]];
    
    [self drawAngle:CIRCPRO_START_UP_POINT endAngle:drawUpCurAngle Color:[UIColor blueColor]];
    
    [self drawUpBallOnCir:CGPointMake(150, 150) radius:100 withAngle:drawUpCurAngle];
}


-(void)DrawBall{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(150, 100, 10, 10)];
    view.layer.cornerRadius = 10 / 2;
    
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor yellowColor];
    
    //1.创建核心动画
    CAKeyframeAnimation *keyAnima=[CAKeyframeAnimation animation];
    //平移
    keyAnima.keyPath=@"position";
    //1.1告诉系统要执行什么动画
    //创建一条路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置一个圆的路径
    //CGPathAddEllipseInRect(path, NULL, CGRectMake(150, 100, 100, 100));
    keyAnima.path=path;
    
    //有create就一定要有release
    CGPathRelease(path);
    //1.2设置动画执行完毕后，不删除动画
    keyAnima.removedOnCompletion=NO;
    //1.3设置保存动画的最新状态
    keyAnima.fillMode=kCAFillModeForwards;
    //1.4设置动画执行的时间
    keyAnima.duration=5.0;
    //1.5设置动画的节奏
    keyAnima.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //设置代理，开始—结束
    keyAnima.delegate=self;
    //2.添加核心动画
    [view.layer addAnimation:keyAnima forKey:nil];
    
    [self addSubview:view];
}




@end
