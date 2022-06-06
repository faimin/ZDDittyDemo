//
//  MDAnimator.h
//  DittyDemo
//
//  Created by Zero.D.Saber on 04/05/2017.
//  Copyright © 2017 Zero.D.Saber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MDAnimationItem, LOTAnimationView;

NS_ASSUME_NONNULL_BEGIN

// 文字动画遵守的协议
@protocol MDAnimationProtocol <NSObject>
+ (instancetype _Nullable )animationWithView:(__kindof UILabel *)view
                                        item:(MDAnimationItem *)item;
- (BOOL)animationAt:(CFTimeInterval)time finished:(BOOL *)finished;

@property (nonatomic, strong) UILabel *targetView;
@property (nonatomic, strong) UIView *bgAnimationView;
@property (nonatomic, weak) UIView *animationSuperView; //此视图已经被父视图持有，不会释放，所以用weak
@end

// 背景动画遵守的协议
@protocol MDBGAnimationProtocol <NSObject>

// TODO: -

@end

//================================================

@interface MDAnimator : NSObject

@property (nonatomic) BOOL useExternalTimer; //default NO
- (void)externalTimerTick:(CFTimeInterval)time;

- (void)addAnimation:(id <MDAnimationProtocol>)ani;
- (void)removeAnimation:(id <MDAnimationProtocol>)ani;
- (void)stop;

@end

NS_ASSUME_NONNULL_END
