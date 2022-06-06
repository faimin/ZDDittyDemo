//
//  MDLightningAnimation.m
//  DittyDemo
//
//  Created by Zero.D.Saber on 2017/6/1.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

#import "MDLightningAnimation.h"

@interface MDLightningAnimation ()

@end

@implementation MDLightningAnimation

+ (instancetype)animationWithView:(__kindof UILabel *)view item:(MDAnimationItem *)item {
    MDLightningAnimation *animation = [MDLightningAnimation new];
    animation.targetView = view;
    animation.item = item;
    
    return animation;
}

- (BOOL)animationAt:(CFTimeInterval)time finished:(BOOL *)finished {
    BOOL shouldStart = [super animationAt:time finished:finished];
    if (finished && *finished) {
        self.targetView.hidden = YES;
        [self.targetView.layer pop_removeAllAnimations];
        [self.targetView removeFromSuperview];
    }
    
    if (!shouldStart) {
        return NO;
    }
    
    _running = YES;
    
    self.targetView.hidden = NO;
    //self.bgAnimationView.hidden = NO;
    
    // 把背景视图和label视图添加到父视图上
    [self.animationSuperView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //[self.animationSuperView addSubview:self.bgAnimationView];
    [self.animationSuperView addSubview:self.targetView];
    
    // 执行动画
    [self lightningShowText];
    [self.bgAnimationView startAnimation];
    
    return YES;
}

- (void)lightningShowText {
    NSAssert(self.targetView.superview, @"父视图为nil");
    
    UIView *bgAnimationView = [[UIView alloc] initWithFrame:self.targetView.superview.bounds];
    bgAnimationView.backgroundColor = [UIColor whiteColor];
    [self.targetView.superview insertSubview:bgAnimationView belowSubview:self.targetView];
    
    self.targetView.text = self.item.word;
    self.targetView.font = [UIFont boldSystemFontOfSize:self.targetView.font.pointSize];
    
    NSTimeInterval duration = self.item.endTime - self.item.startTime;
    NSTimeInterval interval = 0.2;
    
    // 背景
    POPBasicAnimation *animation1 = ({
        POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewBackgroundColor];
        animation.fromValue = [UIColor blackColor];
        animation.toValue = [UIColor whiteColor];
        animation.duration = interval;
        animation.repeatCount = ceil(duration / interval);
        animation.autoreverses = YES;
        animation;
    });
    
    // 文字
    POPBasicAnimation *animation2 = ({
        POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLabelTextColor];
        animation.fromValue = [UIColor whiteColor];
        animation.toValue = [UIColor blackColor];
        animation.duration = interval;
        animation.repeatCount = ceil(duration / interval);
        animation.autoreverses = YES;
        animation;
    });
    animation2.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            bgAnimationView.hidden = YES;
            [bgAnimationView removeFromSuperview];
            
            self.targetView.hidden = YES;
            [self.targetView removeFromSuperview];
        }
    };
    
    // 执行动画
    [bgAnimationView pop_addAnimation:animation1 forKey:nil];
    [self.targetView pop_addAnimation:animation2 forKey:nil];
}


@end



