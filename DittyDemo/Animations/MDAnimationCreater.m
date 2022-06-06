//
//  ZDAnimations.m
//  ZDPopDemo
//
//  Created by Zero.D.Saber on 2017/5/10.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

#import "MDAnimationCreater.h"
#import <pop/POP.h>

static const CFTimeInterval DefaultDuration = 0.8;

@implementation MDAnimationCreater

+ (__kindof POPPropertyAnimation *)animationWithType:(MDAnimationType)type
                                           fromValue:(id)fromValue
                                             toValue:(id)toValue
                                            duration:(CFTimeInterval)duration {
    POPPropertyAnimation *animation;
    switch (type) {
        case MDAnimationType_Scale:
        {
            animation = ({
                POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
                if (fromValue) {
                    springAnimation.fromValue = fromValue;
                }
                springAnimation.toValue = toValue;
                springAnimation.springSpeed = 20.0f;
                springAnimation.springBounciness = 18.0f;
                springAnimation.dynamicsTension = 5.0f;
                springAnimation.dynamicsFriction = 5.0f;
                springAnimation;
            });
        }
            break;
        case MDAnimationType_Rotation:
        {
            animation = ({
                POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
                if (fromValue) {
                    animation.fromValue = fromValue;
                }
                animation.toValue = toValue;
                animation.duration = duration ?: DefaultDuration;
                animation;
            });
        }
            break;
        case MDAnimationType_RotationX:
        {
            NSString *propertyName = (type == MDAnimationType_RotationX) ? kPOPLayerRotationX : kPOPLayerRotationY;
            animation = ({
                POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:propertyName];
                if (fromValue) {
                    animation.fromValue = fromValue;
                }
                animation.toValue = toValue;
                animation.duration = duration ?: DefaultDuration;
                animation;
            });
        }
            break;
        case MDAnimationType_RotationY:
        {
            animation = ({
                POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotationY];
                if (fromValue) {
                    animation.fromValue = fromValue;
                }
                animation.toValue = toValue;
                animation.springBounciness = 18.f;
                animation.dynamicsFriction = 4.f;
                animation.dynamicsTension = 25.f;// 值越大，旋转越快
                animation;
            });
        }
            break;
        case MDAnimationType_PositionY:
        {
            animation = ({
                POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
                animation.fromValue = fromValue;
                animation.toValue = toValue;
                if (duration) {
                    animation.duration = duration;
                }
                animation;
            });
        }
            break;
        case 5:
        {
            animation = ({
                nil;
            });
        }
            break;
        default:
            break;
    }
    
    return animation;
}

@end
