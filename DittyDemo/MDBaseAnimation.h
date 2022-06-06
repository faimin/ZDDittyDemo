//
//  MDBaseAnimation.h
//  DittyDemo
//
//  Created by Zero.D.Saber on 05/05/2017.
//  Copyright © 2017 Zero.D.Saber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDAnimator.h"
#import <pop/POP.h>
#import "MDAnimationItem.h"
#import "AnimationViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN __kindof UIView *MDCopyedView(__kindof UIView *view);

@interface MDBaseAnimation : NSObject <MDAnimationProtocol>
{
    @protected
    /*__weak*/ //__kindof UILabel *_targetView;    ///< 一般为要做动画的label控件
    //MDAnimationItem *_item;                  ///< model
    BOOL _running;
}

/// model
@property (nonatomic, strong) MDAnimationItem *item;

//----Protocol-------
/// bg和label的父视图
@property (nonatomic, weak) UIView *animationSuperView;
/// 做背景动画的背景view，可能为nil
@property (nonatomic, strong, nullable) UIView<AnimationViewProtocol> *bgAnimationView;
/// 做动画用的label视图
@property (nonatomic, strong) UILabel *targetView;

@end
NS_ASSUME_NONNULL_END






