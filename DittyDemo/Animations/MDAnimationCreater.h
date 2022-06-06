//
//  ZDAnimations.h
//  ZDPopDemo
//
//  Created by Zero.D.Saber on 2017/5/10.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

#import <Foundation/Foundation.h>
@class POPPropertyAnimation;


typedef NS_ENUM(NSInteger, MDAnimationType) {
    MDAnimationType_Scale,
    MDAnimationType_Rotation,
    MDAnimationType_RotationX,
    MDAnimationType_RotationY,
    MDAnimationType_PositionY,
};


@interface MDAnimationCreater : NSObject

+ (__kindof POPPropertyAnimation *)animationWithType:(MDAnimationType)type
                                           fromValue:(id)fromValue
                                             toValue:(id)toValue
                                            duration:(CFTimeInterval)duration;

@end
