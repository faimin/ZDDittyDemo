//
//  MDRandomShowAnimation.m
//  DittyDemo
//
//  Created by Zero.D.Saber on 2017/6/1.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

#import "MDRandomShowAnimation.h"

@interface MDRandomShowAnimation () <CAAnimationDelegate>

@end

@implementation MDRandomShowAnimation

+ (instancetype)animationWithView:(__kindof UIView *)view item:(MDAnimationItem *)item {
    
    MDRandomShowAnimation *animation = [MDRandomShowAnimation new];
    animation.targetView = view;
    animation.item = item;
    
    return animation;
}

- (BOOL)animationAt:(CFTimeInterval)time finished:(BOOL *)finished {
    BOOL shouldStart = [super animationAt:time finished:finished];
    if (finished && *finished) {
        [self.targetView.layer removeAllAnimations];
        self.targetView.hidden = YES;
        [self.targetView removeFromSuperview];
    }
    
    if (!shouldStart) {
        return NO;
    }
    
    _running = YES;
    
    self.targetView.hidden = NO;
    self.bgAnimationView.hidden = NO;
    
    // 把背景视图和label视图添加到父视图上
    [self.animationSuperView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.animationSuperView addSubview:self.bgAnimationView];
    [self.animationSuperView addSubview:self.targetView];
    
    // 执行动画
    [self jumpShowText];
    [self.bgAnimationView startAnimation];
    
    return YES;
}

- (void)jumpShowText {
    self.targetView.text = self.item.word;
    [self.targetView sizeToFit];
    self.targetView.center = self.targetView.superview.center;
    
#if 0 //调试用（展示运动轨迹）
    CAShapeLayer *shapeLayer = ({
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = self.label.superview.bounds;
        layer.lineWidth = 5;
        layer.strokeColor = [UIColor greenColor].CGColor;
        layer.fillColor = [[UIColor grayColor] colorWithAlphaComponent:0.3].CGColor; // 所画出区域的填充色
        layer.lineCap = kCALineCapRound;
        layer.lineJoin = kCALineJoinRound;
        layer.path = [self drawJumpPathFromPoint:self.label.center].CGPath;
        layer;
    });
    [self.label.superview.layer addSublayer:shapeLayer];
#endif
    
    // Keyframe animation(离散动画)
    CAKeyframeAnimation *keyFrameAnimation = ({
        CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        keyAnimation.path = [self drawJumpPathFromPoint:(self.targetView).center].CGPath;
        keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        keyAnimation.fillMode = kCAFillModeForwards;
        keyAnimation.calculationMode = kCAAnimationDiscrete;//离散动画
        keyAnimation;
    });
    //[self.label.layer addAnimation:keyFrameAnimation forKey:@"ZD_PostionKeyframeAnimation"];
    
    // 缩小文字
    /*
     POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
     scaleAnimation.toValue = [NSValue valueWithCGSize:(CGSize){0.5, 0.5}];
     scaleAnimation.duration = self.duration;
     [self.label.layer pop_addAnimation:scaleAnimation forKey:@"ZD_ScaleSize"];
     */
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCGSize:(CGSize){1, 1}];
    scaleAnimation.toValue = [NSValue valueWithCGSize:(CGSize){0.5, 0.5}];
    
    // 动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[keyFrameAnimation, scaleAnimation];
    group.duration = (self.item.endTime - self.item.startTime);
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.delegate = self;
    [(self.targetView).layer addAnimation:group forKey:@"ZD_GroupAnimation"];
}

- (UIBezierPath *)drawJumpPathFromPoint:(CGPoint)startPoint {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint]; // startPoint是中心点
    CGFloat w = startPoint.x * 2;
    CGFloat h = startPoint.y * 2;
    CGFloat  ratio = 0.2;
    [path addLineToPoint:(CGPoint){w * ratio, h * (1 - ratio)}];
    [path addLineToPoint:(CGPoint){w * (1 - ratio), h * (1 - ratio)}];
    [path addLineToPoint:(CGPoint){w * ratio, h * ratio}];
    [path addLineToPoint:(CGPoint){w * (1 - ratio), h * ratio}];
    [path addLineToPoint:startPoint];
    [path closePath];
    return path;
}

// 动画结束后
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (!flag) return;
    
    self.targetView.hidden = YES;
    [self.targetView removeFromSuperview];
}

@end
