//
//  MDBaseAnimation.m
//  DittyDemo
//
//  Created by Zero.D.Saber on 05/05/2017.
//  Copyright © 2017 Zero.D.Saber. All rights reserved.
//

#import "MDBaseAnimation.h"
#import "MDAnimationItem.h"

@implementation MDBaseAnimation

- (void)dealloc
{
    NSLog(@"%s\n", __PRETTY_FUNCTION__);
}

+ (instancetype)animationWithView:(UIView *)view item:(MDAnimationItem *)item
{
    NSAssert(YES, @"need override");
    return nil;
}

- (BOOL)animationAt:(CFTimeInterval)time finished:(BOOL *)finished
{
    NSParameterAssert(self.item);
    
    BOOL shouldStart = !_running && (time >= self.item.startTime && time <= self.item.endTime);
    BOOL isFinished = time >= self.item.endTime;
    if (isFinished && finished) { //finished不为空 且 isFinished
        *finished = isFinished;
    }
    return shouldStart;
}

@end

UIView *MDCopyedView(UIView *view)
{
    UIView *v = [[[view class] alloc] initWithFrame:view.frame];
    if ([view isKindOfClass:[UILabel class]]) {
        UILabel *old = (UILabel *)view;
        UILabel *new = (UILabel *)v;
        
        new.textAlignment = old.textAlignment;
        new.text = old.text;
        new.textColor = old.textColor;
        new.font = old.font;
        v = new;
    }
    
    v.hidden = view.hidden;
    v.alpha = view.alpha;
    v.backgroundColor = view.backgroundColor;
    return v;

}



