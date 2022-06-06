//
//  ZDGeometricDotView.h
//  ZDPopDemo
//
//  Created by Zero.D.Saber on 2017/5/24.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

/**
 点点几何动画
 */

#import <UIKit/UIKit.h>
#import "AnimationViewProtocol.h"

@interface ZDGeometricDotView : UIView <AnimationViewProtocol>

@property (nonatomic, assign) NSTimeInterval duration;

@end
