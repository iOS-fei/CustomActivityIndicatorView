//
//  ViewController.m
//  CustomActivityIndicatorView
//
//  Created by 张飞 on 2019/1/21.
//  Copyright © 2019 张飞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,weak) UIView *indicateView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个播放动画的载体view 宽高大有都是50
    UIView *indicateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    indicateView.backgroundColor = [UIColor blackColor];
    indicateView.center = CGPointMake(self.view.center.x-30, self.view.center.y);
    [self.view addSubview:indicateView];
    self.indicateView = indicateView;
    
    //获取载体的宽高
    CGFloat width = indicateView.frame.size.width;
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = CGRectMake(0, 0, width, width);
    replicatorLayer.position = CGPointMake(width/2, width/2);
    replicatorLayer.instanceCount = 10;
    replicatorLayer.instanceDelay = 0.1;
    [indicateView.layer addSublayer:replicatorLayer];
    
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 10, 10);
    layer.position = CGPointMake(width/2, 10);
    layer.cornerRadius = 5;
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    [replicatorLayer addSublayer:layer];
    
    CGFloat angle = (CGFloat)2*M_PI/10;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @0.9;
    scaleAnimation.toValue = @0.1;
    //    scaleAnimation.duration = 1.2;
    //    scaleAnimation.repeatCount = HUGE;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @0.98;
    alphaAnimation.toValue = @0.2;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[scaleAnimation,alphaAnimation];
    groupAnimation.duration = 1.0;
    groupAnimation.repeatCount = HUGE;
    [layer addAnimation:groupAnimation forKey:@"animation"];
    
    [self demo1];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(printInfo) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)printInfo
{
    NSLog(@"%@",NSStringFromCGRect(self.indicateView.frame));
}

- (void)demo1
{
    UIView *indicateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    indicateView.backgroundColor = [UIColor blackColor];
    indicateView.center = CGPointMake(self.view.center.x+30, self.view.center.y);
    [self.view addSubview:indicateView];
    
    CGFloat width = indicateView.bounds.size.width;
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.bounds = CGRectMake(0, 0, width, width);
    //设置中心点为父视图的中点
    replicatorLayer.position = CGPointMake(width/2, width/2);
    //复制图层次数
    replicatorLayer.instanceCount =  10;
    //复制延迟时间
    replicatorLayer.instanceDelay = 0.1;
    [indicateView.layer addSublayer:replicatorLayer];
    
    //创建出小菊花的“叶子”，就是单个的竖条，并且需要将“叶子”添加到复制图层上
    CALayer *layer = [CALayer layer];
    //小菊花“叶子”的宽高
    layer.bounds = CGRectMake(0, 0, 3, 8);
    layer.position = CGPointMake(width/2, 10);
    layer.cornerRadius = 1.5;
    //小菊花的颜色
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicatorLayer addSublayer:layer];
    
    CGFloat angle = (CGFloat)2*M_PI/10;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    
    CABasicAnimation *alphaAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnim.fromValue = [NSNumber numberWithFloat:0.1];
    alphaAnim.toValue = [NSNumber numberWithFloat:0.9];
    alphaAnim.duration = 1;
    alphaAnim.repeatCount = HUGE;
    [layer addAnimation:alphaAnim forKey:nil];
}



@end
