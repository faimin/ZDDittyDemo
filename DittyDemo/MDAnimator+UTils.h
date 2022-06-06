//
//  MDAnimator+UTils.h
//  DittyDemo
//
//  Created by Zero.D.Saber on 05/05/2017.
//  Copyright © 2017 Zero.D.Saber. All rights reserved.
//

#import "MDAnimator.h"
#import <UIKit/UIKit.h>
@protocol AnimationViewProtocol;

@interface MDAnimator (UTils)

- (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color;

- (id <MDAnimationProtocol>)animationWithView:(UILabel *)label item:(MDAnimationItem *)item;

- (UIView<AnimationViewProtocol> *)animationBGViewWithItem:(MDAnimationItem *)item;

@end
