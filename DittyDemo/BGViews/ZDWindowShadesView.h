//
//  ZDWindowShadesView.h
//  ZDPopDemo
//
//  Created by Zero.D.Saber on 2017/5/23.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

/**
 百叶窗动画效果
 */

#import <UIKit/UIKit.h>
#import "AnimationViewProtocol.h"

typedef NS_ENUM(NSInteger, ShowDirection) {
    ShowDirection_RightToLeft = 0,
    ShowDirection_MiddleToSide,
    ShowDirection_LeftToRight
};

@interface ZDWindowShadesView : UIView <AnimationViewProtocol>

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) ShowDirection direction;

@end
