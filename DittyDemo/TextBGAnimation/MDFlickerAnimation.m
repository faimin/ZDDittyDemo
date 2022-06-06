//
//  MDFlickerAnimation.m
//  DittyDemo
//
//  Created by Zero.D.Saber on 2017/6/1.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

#import "MDFlickerAnimation.h"

@interface MDFlickerAnimation ()

@end

@implementation MDFlickerAnimation

+ (instancetype)animationWithView:(__kindof UILabel *)view item:(MDAnimationItem *)item {
    MDFlickerAnimation *animation = [MDFlickerAnimation new];
    animation.targetView = view;
    animation.item = item;
    
    return animation;
}

- (BOOL)animationAt:(CFTimeInterval)time finished:(BOOL *)finished {
    BOOL shouldStart = [super animationAt:time finished:finished];
    if (finished && *finished) {
        [self.targetView.layer pop_removeAllAnimations];
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
    [self flickerShowText];
    [self.bgAnimationView startAnimation];
    
    return YES;
}

#pragma mark - Animation

- (void)flickerShowText {
    self.targetView.text = self.item.word;
    [self.targetView sizeToFit];
    NSAssert(self.targetView.superview, @"label父视图不能为nil");
    self.targetView.center = self.targetView.superview.center;
    
    POPSpringAnimation *animation = ({
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        animation.fromValue = [NSValue valueWithCGSize:(CGSize){0.2, 0.2}];
        animation.toValue = [NSValue valueWithCGSize:(CGSize){1.2, 1.2}];
        animation.springSpeed = 10.f;
        animation.springBounciness = 18.f;
        //animation.dynamicsFriction = 4.f;
        //animation.dynamicsTension = 1005.f;// 张力
        animation;
    });
    animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            [self.bgAnimationView removeFromSuperview];
        }
    };
    
    [self.targetView.layer pop_addAnimation:animation forKey:nil];
}


@end
