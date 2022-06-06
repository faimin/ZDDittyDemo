//
//  MDShadowAnimation.m
//  DittyDemo
//
//  Created by Zero.D.Saber on 2017/6/1.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

#import "MDShadowAnimation.h"
#import "ZDFunction.h"

@interface MDShadowAnimation ()
@property (nonatomic, strong) UIView *bgView;
@end

@implementation MDShadowAnimation

+ (instancetype)animationWithView:(__kindof UILabel *)view item:(MDAnimationItem *)item {
    MDShadowAnimation *animation = [MDShadowAnimation new];
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
    //self.bgAnimationView.hidden = NO;
    
    // 先移除旧视图，再把背景视图和label视图添加到父视图上
    [self.animationSuperView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.bgView = ({
        UIView *view = [[UIView alloc] initWithFrame:self.bgAnimationView.frame];
        view.backgroundColor = RandomColor();
        view;
    });
    //[self.animationSuperView addSubview:self.bgAnimationView];
    [self.animationSuperView addSubview:self.bgView];
    [self.animationSuperView addSubview:self.targetView];
    
    // 执行动画
    [self shadowAnimation];
    //[self.bgAnimationView startAnimation];
    
    return YES;
}

#pragma mark - Animation
/// 模拟背影效果
- (void)shadowAnimation {
    self.targetView.text = self.item.word;
    
    [self.targetView sizeToFit];
    self.targetView.center = self.targetView.superview.center;
    
    // 数组里放的都是阴影视图，不包含self.label
    //NSMutableArray<UILabel *> *shadowViews = @[].mutableCopy;
    NSInteger count = 4, offset = 7;
    for (NSInteger i = 0; i < count; i++) {
        UILabel *label = ZD_CloneView(self.targetView);
        label.textColor = RandomColor();
        label.frame = self.targetView.frame;
        [self.targetView.superview insertSubview:label belowSubview:self.targetView];
        //[shadowViews addObject:label];
        
        NSInteger index = count - i;
        [self setupAnimation:label toValue:(CGPoint){index * offset, index * (offset + 0)}];
    }
}

- (void)setupAnimation:(UIView *)label toValue:(CGPoint)point {
    // if (CGPointEqualToPoint(point, CGPointZero)) return;
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationXY];
    animation.toValue = [NSValue valueWithCGPoint:point];
    // 因为动画还要reverse，所以时间还得除以2
    animation.duration = (self.item.endTime - self.item.startTime) / 2.0;
    animation.autoreverses = YES;
    animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            label.hidden = YES;
            [label removeFromSuperview];
            [self.bgView removeFromSuperview];
        }
    };
    [label.layer pop_addAnimation:animation forKey:nil];
}


@end
