//
//  ZDSectorView.m
//  ZDPopDemo
//
//  Created by Zero.D.Saber on 2017/5/26.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

#import "ZDSectorView.h"
#import <pop/POP.h>
#import "ZDFunction.h"

@interface ZDSectorView ()
@property (nonatomic, strong) NSArray<CALayer *> *leftLayers;
@property (nonatomic, strong) NSArray<CALayer *> *rightLayers;
@end

@implementation ZDSectorView

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self setup];
}

#pragma mark -

- (void)setup {
    [self setupUI];
}

- (void)setupUI {
    if (CGRectEqualToRect(self.frame, CGRectZero)) return;
    if (self.layer.sublayers.count > 0) {
        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    }
    
    CGRect leftFrame, rightFrame;
    CGRectDivide(self.bounds, &leftFrame, &rightFrame, CGRectGetMidX(self.bounds), CGRectMinXEdge);
    CALayer *left1 = [self layerWithFrame:leftFrame backgroundColor:RandomColor().CGColor isLeft:YES];
    CALayer *left2 = [self layerWithFrame:leftFrame backgroundColor:RandomColor().CGColor isLeft:YES];
    CALayer *left3 = [self layerWithFrame:leftFrame backgroundColor:RandomColor().CGColor isLeft:YES];
    
    CALayer *right1 = [self layerWithFrame:rightFrame backgroundColor:left1.backgroundColor isLeft:NO];
    CALayer *right2 = [self layerWithFrame:rightFrame backgroundColor:left2.backgroundColor isLeft:NO];
    CALayer *right3 = [self layerWithFrame:rightFrame backgroundColor:left3.backgroundColor isLeft:NO];
    
    NSArray<CALayer *> *leftLayers = @[left1, left2, left3];
    NSArray<CALayer *> *rightLayers = @[right1, right2, right3];
    
    for (CALayer *layer in leftLayers) {
        [self.layer addSublayer:layer];
    }
    for (CALayer *layer in rightLayers) {
        [self.layer addSublayer:layer];
    }
    
    self.leftLayers = leftLayers;
    self.rightLayers = rightLayers;
}

- (CALayer *)layerWithFrame:(CGRect)frame
            backgroundColor:(CGColorRef)backgroundColor
                     isLeft:(BOOL)isLeft {
    CALayer *layer = [[CALayer alloc] init];
    layer.anchorPoint = isLeft ? (CGPoint){1, 0} : (CGPoint){0, 0};
    CGFloat w = CGRectGetWidth(frame);
    CGFloat h = CGRectGetHeight(frame);
    CGRect newFrame = (CGRect){frame.origin, w, ceil(hypotf(w, h))};
    layer.frame = newFrame;
    layer.backgroundColor = backgroundColor;
    return layer;
}

#pragma mark - Public Method

- (void)startAnimation {
    //NSUInteger count = self.leftLayers.count;
    
    CFTimeInterval begin = CACurrentMediaTime();
    
    __block POPBasicAnimation *lastAnimation;
    [self.leftLayers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        POPBasicAnimation *animation = [self animationFromValue:@(0) toValue:@(M_PI_2) withIndex:idx];
        if (idx == 0) {
            lastAnimation = animation;
        }
        animation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
            if (finished && (idx == 0) && [anim isEqual:lastAnimation]) {
                CFTimeInterval end = CACurrentMediaTime();
                CFTimeInterval interval = end - begin;
                NSLog(@"%f", interval);
                
                [self removeFromSuperview];
            }
        };
        [obj pop_addAnimation:animation forKey:nil];
    }];
    
    [self.rightLayers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        POPBasicAnimation *animation = [self animationFromValue:@(0) toValue:@(-M_PI_2) withIndex:idx];

        [obj pop_addAnimation:animation forKey:nil];
    }];
    
    
}

#pragma mark - POPAnimationDelegate



#pragma mark -

- (POPBasicAnimation *)animationFromValue:(id)fromValue
                                  toValue:(id)toValue
                                withIndex:(NSUInteger)idx {
    /*
     X为每个动画之间的时间间隔
     1/3 * X + 1/3 * X + X = duration
     */
    
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion = YES;
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.duration = self.duration / 5 * 3;
    
    NSInteger index = (self.leftLayers.count - 1) - idx;
    animation.beginTime = CACurrentMediaTime() + (self.duration / 5 * index);
    
    return animation;
}


@end
