//
//  MDAnimator+UTils.m
//  DittyDemo
//
//  Created by Zero.D.Saber on 05/05/2017.
//  Copyright © 2017 Zero.D.Saber. All rights reserved.
//

#import "MDAnimator+UTils.h"
#import "MDAnimationItem.h"
//#import "MDBangAnimation.h"
//#import "MDShadowMergeAnimation.h"
//#import "MDRotationAnimation.h"
// 新文字动画视图
#import "MDOneByOneShowAnimation.h"
#import "MDRandomShowAnimation.h"
#import "MDLightningAnimation.h"
#import "MDFlickerAnimation.h"
#import "MDShadowAnimation.h"
// 背景动画视图
#import "ZDGeometricDotView.h"
#import "ZDSectorView.h"
#import "ZDWindowShadesView.h"
#import "ZDPolygonView.h"
#import "ZDScaleRotationView.h"

@interface MDAnimator ()

@end

@implementation MDAnimator (UTils)

/// 创建背景视图
- (UIView<AnimationViewProtocol> *)animationBGViewWithItem:(MDAnimationItem *)item {
    NSUInteger random = arc4random() % 5;
    
    __kindof UIView<AnimationViewProtocol> *bgAnimationView = nil;
    switch (random) {
        case 0:
        {
            bgAnimationView = [[ZDGeometricDotView alloc] init];
        }
            break;
        case 1:
        {
            bgAnimationView = [[ZDSectorView alloc] init];
        }
            break;
        case 2:
        {
            bgAnimationView = [[ZDWindowShadesView alloc] init];
            ((ZDWindowShadesView *)bgAnimationView).direction = arc4random() % 3;
        }
            break;
        case 3:
        {
            bgAnimationView = [[ZDPolygonView alloc] init];
        }
            break;
        case 4:
        {
            bgAnimationView = [[ZDScaleRotationView alloc] init];
        }
            break;
        default:
            break;
    }
    
    bgAnimationView.duration = item.endTime - item.startTime;
    
    return bgAnimationView;
}

- (UILabel *)labelWithText:(NSString *)text
                      font:(UIFont *)font
                 textColor:(UIColor *)color
{
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    label.text = text;
    label.font = font;
    label.textColor = color;
    [label sizeToFit];
    label.hidden = YES;
    return label;
}

/// 创建文字动画
- (id <MDAnimationProtocol>)animationWithView:(UILabel *)label
                                         item:(MDAnimationItem *)item
{
//    static NSUInteger cnt = 0;
//    cnt++;
    
    NSUInteger cnt = arc4random() % 5;
    
    id <MDAnimationProtocol> animation;
    switch (cnt) {  // 5种文字动画
        case 0:
            //animation = [MDBangAnimation animationWithView:label item:item];
            animation = [MDOneByOneShowAnimation animationWithView:label item:item];
            break;
        case 1:
            //animation = [MDShadowMergeAnimation animationWithView:label item:item];
            animation = [MDRandomShowAnimation animationWithView:label item:item];
            break;
        case 2:
            //animation = [MDRotationAnimation animationWithView:label item:item];
            animation = [MDLightningAnimation animationWithView:label item:item];
            break;
        case 3:
            animation = [MDFlickerAnimation animationWithView:label item:item];
            break;
        case 4:
            animation = [MDShadowAnimation animationWithView:label item:item];
            break;
        case 5:
            // next to do something
            break;
        default:
            break;
    }
    
    return animation;
}



@end
