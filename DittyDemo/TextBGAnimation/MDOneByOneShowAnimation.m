//
//  MDOneByOneShowAnimation.m
//  DittyDemo
//
//  Created by Zero.D.Saber on 2017/6/1.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

#import "MDOneByOneShowAnimation.h"

@interface MDOneByOneShowAnimation ()

@end

@implementation MDOneByOneShowAnimation

+ (instancetype)animationWithView:(__kindof UIView *)view item:(MDAnimationItem *)item {
    
    MDOneByOneShowAnimation *animation = [MDOneByOneShowAnimation new];
    animation.targetView = view;
    animation.item = item;
    
    return animation;
}

// 如果动画已经结束，则移除view上的动画
- (BOOL)animationAt:(CFTimeInterval)time finished:(BOOL *)finished {
    BOOL shouldStart = [super animationAt:time finished:finished];
    
    if (finished && *finished) {
        // 先隐藏 再移除
        self.targetView.hidden = YES;
        self.bgAnimationView.hidden = YES;
        
        [self.targetView removeFromSuperview];
        [self.bgAnimationView removeFromSuperview];
    }
    
    if (!shouldStart) return NO;
    
    _running = YES;
    
    self.targetView.hidden = NO;
    self.bgAnimationView.hidden = NO;
    
    // 把背景视图和label视图添加到父视图上
    [self.animationSuperView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.animationSuperView addSubview:self.bgAnimationView];
    [self.animationSuperView addSubview:self.targetView];
    
    // 伪文字动画
    UILabel *label = self.targetView;
    label.textAlignment = NSTextAlignmentCenter;
    label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    label.adjustsFontSizeToFitWidth = YES;
    label.attributedText = nil;
    label.text = nil;
    
    NSString *willShowText = self.item.word;
    NSTimeInterval duration = self.item.endTime - self.item.startTime;
    NSTimeInterval interval = (duration - 0.2) / willShowText.length;
    
    for (NSUInteger i = 0; i < willShowText.length; i++) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *text = [willShowText substringToIndex:(i+1)];
            NSMutableAttributedString *mutAttStr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSKernAttributeName : @(2)}];//设置字间距
            label.attributedText = mutAttStr;
        });
    }
    
    // 到时间后移除视图
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [label removeFromSuperview];
    });
    
    // 开启背景动画
    [self.bgAnimationView startAnimation];
    
    return YES;
}


@end







