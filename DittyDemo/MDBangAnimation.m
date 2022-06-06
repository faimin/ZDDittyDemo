//
//  MDBangAnimation.m
//  DittyDemo
//
//  Created by Zero.D.Saber on 04/05/2017.
//  Copyright © 2017 Zero.D.Saber. All rights reserved.
//

#import "MDBangAnimation.h"
#import "MDAnimationItem.h"
#import <pop/POP.h>


@interface MDBangAnimation ()
@property (nonatomic, strong) POPSpringAnimation *spring;
@end

@implementation MDBangAnimation

+ (instancetype)animationWithView:(UILabel *)view item:(MDAnimationItem *)item
{
    NSParameterAssert([view isKindOfClass:[UIView class]]);
    NSParameterAssert([item isKindOfClass:[MDAnimationItem class]]);
    
    MDBangAnimation *ani = [[MDBangAnimation alloc] init];
    ani.targetView = view;
    ani.item = item;
    
    ani.spring = ({
        POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        spring.springSpeed = 20;
        spring.springBounciness = 12;
        spring.fromValue = [NSValue valueWithCGSize:CGSizeMake(5.f, 5.f)];
        spring.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
        spring;
    });
    
    /*
    ani.lotView = ({
        LOTAnimationView *lotView = [MDBGAnimation lotAnimationViewWithType:random() % 3];
        lotView.frame = view.superview.bounds;
        [view.superview insertSubview:lotView atIndex:0];
        lotView;
    });
     */
    
    view.hidden = YES;
    //view.layer.affineTransform = CGAffineTransformScale(view.layer.affineTransform, 5, 5);

    return ani;
}


- (BOOL)animationAt:(CFTimeInterval)time finished:(BOOL *)finished
{
    BOOL shouldStart = [super animationAt:time finished:finished];
    if (finished && *finished) {
        [self.targetView.layer pop_removeAllAnimations];
        self.targetView.hidden = YES;
    }
    if (!shouldStart) {
        return NO;
    }
    
    
    
    //MARK: lottie play
//    __weak typeof(self.lotView) weakTarget = self.lotView;
//    [self.lotView playWithCompletion:^(BOOL animationFinished) {
//        __strong typeof(weakTarget) strongTarget = weakTarget;
//        if (animationFinished) {
//            [strongTarget removeFromSuperview];
//        }
//    }];
    
    
    _running = YES;
    self.targetView.hidden = NO;
    CFAbsoluteTime s = CFAbsoluteTimeGetCurrent();
    __weak typeof(self) weakSelf = self;
    
    self.spring.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (!strongSelf) {
                return ;
            }
            [strongSelf.targetView.layer pop_removeAllAnimations];
            strongSelf.targetView.hidden = YES;
            
            CFAbsoluteTime e = CFAbsoluteTimeGetCurrent();
            printf("bang interval: %f \n", (e - s) * 1000);
        }
    };
    [self.targetView.layer pop_addAnimation:self.spring forKey:nil];
    
    
    return YES;
}


@end
