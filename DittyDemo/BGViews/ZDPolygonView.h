//
//  ZDPolygonView.h
//  ZDPopDemo
//
//  Created by Zero.D.Saber on 2017/6/1.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

/**
 多边形放大动画
 */

#import <UIKit/UIKit.h>
#import "AnimationViewProtocol.h"

@interface ZDPolygonView : UIView <AnimationViewProtocol>

@property (nonatomic, assign) NSTimeInterval duration;

@end
