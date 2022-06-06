//
//  MDShadowMergeAnimation.m
//  DittyDemo
//
//  Created by Zero.D.Saber on 05/05/2017.
//  Copyright © 2017 Zero.D.Saber. All rights reserved.
//

#import "MDShadowMergeAnimation.h"
#import "MDAnimationItem.h"

@interface MDShadowMergeAnimation ()
//@property (nonatomic, strong) POPAnimation *shadowPOP;
//@property (nonatomic, strong) UIView *rightTop;
//@property (nonatomic, strong) UIView *rightTopShadow;
//@property (nonatomic, strong) UIView *leftBottmShadow;

@property (nonnull, strong) NSMutableDictionary<NSNumber *, NSArray *> *views;

@end


@implementation MDShadowMergeAnimation

- (POPAnimation *)viewAnimation
{
    POPBasicAnimation *pop = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    pop.toValue = [NSValue valueWithCGPoint:self.targetView.superview.center];
    pop.duration = self.item.endTime - self.item.startTime;
    //pop.removedOnCompletion = YES;
    return pop;
}

- (POPAnimation *)shadowAnimationWithDuration:(CFTimeInterval)du
{
    POPBasicAnimation *shadowPOP = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    shadowPOP.toValue = [NSValue valueWithCGPoint:self.targetView.superview.center];
    shadowPOP.duration = du;
    shadowPOP.removedOnCompletion = YES;
    return shadowPOP;
}

+ (instancetype)animationWithView:(UILabel *)view item:(MDAnimationItem *)item
{
    NSParameterAssert([view isKindOfClass:[UIView class]]);
    NSParameterAssert([item isKindOfClass:[MDAnimationItem class]]);
    NSParameterAssert([view.superview isKindOfClass:[UIView class]]);
    
    MDShadowMergeAnimation *ani = [MDShadowMergeAnimation new];
    ani.targetView = view;
    ani.item = item;
    
    NSMutableDictionary *views = @{}.mutableCopy;
    NSMutableArray *v0Arr = @[].mutableCopy;
    [views setObject:v0Arr forKey:@0];
    
    NSUInteger width = (NSUInteger)view.superview.frame.size.width;
    CGFloat dy = arc4random() % width;
    // leftTop / leftBottom
    view.hidden = YES;
    view.center = CGPointMake(0, dy);
    [v0Arr addObject:view];
    
    // rightTop / rightBottom
    UIView *rightTop = MDCopyedView(view);
    [view.superview addSubview:rightTop];
    rightTop.center = CGPointMake(width, width - dy);
    [v0Arr addObject:rightTop];
    
    for (int i = 1; i <= item.shadowCount; i++)
    {
        NSMutableArray *viArr = @[].mutableCopy;
        
        UIView *rightTopShadow = MDCopyedView(view);
        [view.superview addSubview:rightTopShadow];
        rightTopShadow.center = rightTop.center;
        rightTopShadow.alpha = .5;
        [viArr addObject:rightTopShadow];
        
        UIView *leftBottmShadow = MDCopyedView(view);
        [view.superview addSubview:leftBottmShadow];
        leftBottmShadow.center = view.center;
        leftBottmShadow.alpha = .5;
        [viArr addObject:leftBottmShadow];
        
        [views setObject:viArr forKey:@(i)];
        
    }
    ani.views = views;
    
//    ani.lotView = ({
//        LOTAnimationView *lotView = [MDBGAnimation lotAnimationViewWithType:random() % 3];
//        lotView.frame = view.superview.bounds;
//        [view.superview insertSubview:lotView atIndex:0];
//        lotView;
//    });
    
    return ani;
}

- (BOOL)animationAt:(CFTimeInterval)time finished:(BOOL *)finished
{
    BOOL shouldStart = [super animationAt:time finished:finished];
    if (finished && *finished) {
        [self.views enumerateKeysAndObjectsUsingBlock:^(NSNumber *  _Nonnull key, NSArray *  _Nonnull obj, BOOL * _Nonnull stop) {
            for (UIView *v in obj) {
                v.hidden = YES;
                [v pop_removeAllAnimations];
            }
        }];
    }
    
    if (!shouldStart) {
        return NO;
    }
    
    /*
    //MARK: lottie play
    __weak typeof(self.lotView) weakTarget = self.lotView;
    [self.lotView playWithCompletion:^(BOOL animationFinished) {
        __strong typeof(weakTarget) strongTarget = weakTarget;
        if (animationFinished) {
            [strongTarget removeFromSuperview];
        }
    }];
     */
    
    _running = YES;
    __block POPAnimation *pop;
    [self.views enumerateKeysAndObjectsUsingBlock:^(NSNumber *  _Nonnull key, NSArray *  _Nonnull obj, BOOL * _Nonnull stop) {
        for (UIView *v in obj)
        {
            v.hidden = NO;
            if ([key isEqualToNumber:@0]) {
                POPAnimation *p = [self viewAnimation];
                pop = p;
                [v pop_addAnimation:p forKey:nil];
            } else {
                NSUInteger index = [key unsignedIntegerValue];
                POPAnimation *p = [self shadowAnimationWithDuration:self.item.endTime - self.item.startTime + 0.2 * index];
                [v pop_addAnimation:p forKey:nil];
            }
        }
    }];
    
    /*
    __weak typeof(self) weakSelf = self;
    pop.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.views enumerateKeysAndObjectsUsingBlock:^(NSNumber *  _Nonnull key, NSArray *  _Nonnull obj, BOOL * _Nonnull stop) {
                for (UIView *v in obj) {
                    v.hidden = YES;
                }
            }];
        }
    };
    */
    return YES;
}

@end
