//
//  ZDSectorView.h
//  ZDPopDemo
//
//  Created by Zero.D.Saber on 2017/5/26.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

/**
 扇形动画
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AnimationViewProtocol.h"

@interface ZDSectorView : UIView <AnimationViewProtocol>

@property (nonatomic, assign) NSTimeInterval duration;

@end
