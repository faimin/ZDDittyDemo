//
//  ZDFunction.m
//  ZDPopDemo
//
//  Created by Zero.D.Saber on 2017/5/25.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

#import "ZDFunction.h"


CGPoint ZD_LeftTopPoint(CGRect originFrame) {
    return (CGPoint){CGRectGetMinX(originFrame), CGRectGetMinY(originFrame)};
}

CGPoint ZD_LeftBottomPoint(CGRect originFrame) {
    return (CGPoint){CGRectGetMinX(originFrame), CGRectGetMaxY(originFrame)};
}

CGPoint ZD_RightTopPoint(CGRect originFrame) {
    return (CGPoint){CGRectGetMaxX(originFrame), CGRectGetMinY(originFrame)};
}

CGPoint ZD_RightBottomPoint(CGRect originFrame) {
    return (CGPoint){CGRectGetMaxX(originFrame), CGRectGetMaxY(originFrame)};
}

CGPoint ZD_PointScale(CGPoint originPoint, CGFloat scale) {
    CGFloat x = originPoint.x * scale;
    CGFloat y = originPoint.y * scale;
    return (CGPoint){x, y};
}

CGPoint ZD_PointOffset(CGPoint originPoint, CGPoint offset) {
    return (CGPoint){originPoint.x + offset.x, originPoint.y + offset.y};
}

CGSize ZD_ScreenSize() {
    return [UIScreen mainScreen].bounds.size;
}

UIColor *RandomColor() {
    /*
    CGFloat hue = (arc4random() % 256 / 256.0);
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    */
    
    NSArray<UIColor *> *colorArr = @[
      ZD_UIColorFromHEX(3462FF),
      ZD_UIColorFromHEX(F69231),
      ZD_UIColorFromHEX(63B000),
      ZD_UIColorFromHEX(00B7B5),
      ZD_UIColorFromHEX(E2305c),
      ZD_UIColorFromHEX(B134FA),
      ZD_UIColorFromHEX(7911FF),
      ZD_UIColorFromHEX(00C0FF),
      ZD_UIColorFromHEX(FFE700),
      ZD_UIColorFromHEX(AEFA00),
      ZD_UIColorFromHEX(00E0D0),
      ZD_UIColorFromHEX(F08DA6),
      ZD_UIColorFromHEX(E28AFF),
      ZD_UIColorFromHEX(B082FF)
    ];
    
    NSUInteger idx = arc4random() % colorArr.count;
    UIColor *color = colorArr[idx];
    
    return color;
}

UIView *ZD_CloneView(UIView *view) {
    UIView *v = [[[view class] alloc] initWithFrame:view.frame];
    if ([view isKindOfClass:[UILabel class]]) {
        UILabel *old = (UILabel *)view;
        UILabel *new = (UILabel *)v;
        
        new.textAlignment = old.textAlignment;
        new.baselineAdjustment = old.baselineAdjustment;
        new.text = old.text;
        new.attributedText = old.attributedText;
        new.textColor = old.textColor;
        new.font = old.font;
        v = new;
    }
    
    v.hidden = view.hidden;
    v.alpha = view.alpha;
    v.backgroundColor = view.backgroundColor;
    
    v.layer.shadowColor = view.layer.shadowColor;
    v.layer.shadowOffset = view.layer.shadowOffset;
    v.layer.shadowRadius = view.layer.shadowRadius;
    
    v.layer.cornerRadius = view.layer.cornerRadius;
    return v;
}
