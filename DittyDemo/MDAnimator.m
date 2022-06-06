//
//  MDAnimator.m
//  DittyDemo
//
//  Created by Zero.D.Saber on 04/05/2017.
//  Copyright © 2017 Zero.D.Saber. All rights reserved.
//

#import "MDAnimator.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@class MDBaseAnimation;

@interface MDAnimator ()
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) NSMutableSet<id<MDAnimationProtocol>> *animationSet;   ///< 文字动画集合
@property (nonatomic, assign) CFTimeInterval startTime;
@property (nonatomic, assign) CFTimeInterval pausedTime;
@end

@implementation MDAnimator

+ (void)load
{
//    static MDAnimator *obj;
//    obj = [[MDAnimator alloc] init];
//    [obj addAnimation:@"a"];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _displayLink = [[UIScreen mainScreen] displayLinkWithTarget:self selector:@selector(animationTick:)];
        _displayLink.paused = YES;
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        _animationSet = [NSMutableSet set];
        _startTime = 0.f;
        _pausedTime = 0.f;
    }
    return self;
}

- (void)addAnimation:(id <MDAnimationProtocol>)ani
{
    NSParameterAssert(ani != nil);
    
    [self.animationSet addObject:ani];
    
    if (!self.useExternalTimer && self.animationSet.count == 1) {
        [self setTimerPaused:NO];
    }
}

- (void)removeAnimation:(id <MDAnimationProtocol>)ani
{
    NSParameterAssert(ani != nil);
    [self.animationSet removeObject:ani];
    if (!self.useExternalTimer && self.animationSet.count == 0) {
        [self setTimerPaused:YES];
    }
}

- (void)externalTimerTick:(CFTimeInterval)time
{
    [self _timerTick:time];
}

- (void)stop
{
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)animationTick:(CADisplayLink *)displayLink
{
    NSLog(@"dt: %f, ts: %f, diff: %f", displayLink.duration, displayLink.timestamp, displayLink.timestamp - self.startTime);
    
    // 当前距离开始时的时间差
    // timestamp是上次屏幕刷新时的时间戳
    CFTimeInterval time = displayLink.timestamp - self.startTime;
    [self _timerTick:time];
    
    if (self.animationSet.count == 0) {
        [self setTimerPaused:YES];
    }
}

//MARK:- 最终执行动画的地方
- (void)_timerTick:(CFTimeInterval)time
{
    for (id <MDAnimationProtocol> ani in self.animationSet.copy) {
        BOOL finished = NO;
        [ani animationAt:time finished:&finished];
        
        if (finished) {
            [self.animationSet removeObject:ani];
        }
    }
}

- (void)setTimerPaused:(BOOL)paused
{
    if (self.displayLink.paused == paused) {
        return;
    }
    
    self.displayLink.paused = paused;
    if (paused) {
        self.pausedTime = CACurrentMediaTime();
    } else {
        if (self.startTime <= 0) {
            self.startTime = CACurrentMediaTime();
        }
        
        // 如果displayLink暂停了，开始时间则要加上(现在时间到暂停时间戳之间的时间间隔)
        if (self.pausedTime > 0) {
            self.startTime += (CACurrentMediaTime() - self.pausedTime);
            self.pausedTime = 0.f;
        }
    }
}

- (void)dealloc
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end
