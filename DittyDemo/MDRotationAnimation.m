//
//  MDSpringAnimation.m
//  DittyDemo
//
//  Created by Zero.D.Saber on 2017/5/9.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

#import "MDRotationAnimation.h"
#import <CoreFoundation/CoreFoundation.h>


@interface MDRotationAnimation ()
@property (nonatomic, strong) POPPropertyAnimation *spring;
@end


@implementation MDRotationAnimation

+ (instancetype)animationWithView:(UILabel *)view item:(MDAnimationItem *)item {

    // 翻转动画
    POPBasicAnimation *basicAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotationX];
    basicAnimation.toValue = @(M_PI * 2);
    basicAnimation.duration = item.endTime - item.startTime;
    basicAnimation.removedOnCompletion = YES;
    
    MDRotationAnimation *animation = [MDRotationAnimation new];
    animation.targetView = view;
    animation.item = item;
    animation.spring = basicAnimation;
    
    /*
    animation.lotView = ({
        LOTAnimationView *lotView = [MDBGAnimation lotAnimationViewWithType:random() % 3];
        lotView.frame = view.superview.bounds;
        [view.superview insertSubview:lotView atIndex:0];
        lotView;
    });
     */
    
    return animation;
}

// 如果动画已经结束，则移除view上的动画
- (BOOL)animationAt:(CFTimeInterval)time finished:(BOOL *)finished {
    BOOL shouldStart = [super animationAt:time finished:finished];
    
    if (finished && *finished) {
        [self.targetView.layer pop_removeAllAnimations];
        self.targetView.hidden = YES;
    }
    
    if (!shouldStart) return NO;
    
    /*
    //MARK: lottie play
    __weak typeof(self.lotView) weakView = self.lotView;
    [self.lotView playWithCompletion:^(BOOL animationFinished) {
        __strong typeof(weakView) strongView = weakView;
        if (animationFinished) {
            [strongView removeFromSuperview];
        }
    }];
     */
    
    _running = YES;
    self.targetView.hidden = NO;
    
    CFAbsoluteTime beginTime = CFAbsoluteTimeGetCurrent();
    __weak typeof(self) weakTarget = self;
    self.spring.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            __strong typeof(weakTarget) self = weakTarget;
            [self.targetView.layer pop_removeAllAnimations];
            self.targetView.hidden = YES;
            
            CFAbsoluteTime endTime = CFAbsoluteTimeGetCurrent();
            printf("rotation interval: %f \n", endTime - beginTime);
        }
    };
    
    [self.targetView.layer pop_addAnimation:self.spring forKey:@"MD_RotationXKey"];
    
    return YES;
}

@end



#if 0
// 缩放动画
POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
springAnimation.fromValue = [NSValue valueWithCGSize:(CGSize){6, 6}];
springAnimation.toValue = [NSValue valueWithCGSize:(CGSize){1.f, 1.f}];
springAnimation.springSpeed = 20.0f;
springAnimation.springBounciness = 18.0f;
springAnimation.dynamicsTension = 5.0f;
springAnimation.dynamicsFriction = 5.0f;
#endif



















