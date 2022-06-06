//
//  ZDFunction.h
//  ZDPopDemo
//
//  Created by Zero.D.Saber on 2017/5/25.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define ZD_UIColorFromHEX(rgbValue)                                         \
[UIColor colorWithRed:((float)((0x##rgbValue & 0xFF0000) >> 16)) / 255.0    \
                green:((float)((0x##rgbValue & 0xFF00) >> 8)) / 255.0       \
                 blue:((float)(0x##rgbValue & 0xFF)) / 255.0                \
                alpha: 1.0]


FOUNDATION_EXPORT CGPoint ZD_LeftTopPoint(CGRect originFrame);
FOUNDATION_EXPORT CGPoint ZD_LeftBottomPoint(CGRect originFrame);
FOUNDATION_EXPORT CGPoint ZD_RightTopPoint(CGRect originFrame);
FOUNDATION_EXPORT CGPoint ZD_RightBottomPoint(CGRect originFrame);

FOUNDATION_EXPORT CGPoint ZD_PointScale(CGPoint originPoint, CGFloat scale);
FOUNDATION_EXPORT CGPoint ZD_PointOffset(CGPoint originPoint, CGPoint offset);

FOUNDATION_EXPORT CGSize ZD_ScreenSize();

UIKIT_EXTERN UIColor *RandomColor();

UIKIT_EXTERN __kindof UIView *ZD_CloneView(__kindof UIView *view);








