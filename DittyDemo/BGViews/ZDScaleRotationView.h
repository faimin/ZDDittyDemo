//
//  ZDScaleSquareView.h
//  ZDPopDemo
//
//  Created by Zero.D.Saber on 2017/6/2.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

/**
 正方形旋转缩放动画
 */

#import <UIKit/UIKit.h>
#import "AnimationViewProtocol.h"

@interface ZDScaleRotationView : UIView <AnimationViewProtocol>

@property (nonatomic, assign) NSTimeInterval duration;

@end
