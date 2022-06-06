//
//  MDAnimationItem.h
//  DittyDemo
//
//  Created by Zero.D.Saber on 04/05/2017.
//  Copyright © 2017 Zero.D.Saber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDAnimationItem : NSObject
@property (nonatomic, copy) NSString *word;     ///< 文字
@property (nonatomic) CFTimeInterval startTime; ///< 动画开始时间
@property (nonatomic) CFTimeInterval endTime;   ///< 动画结束时间
@property (nonatomic) CFTimeInterval noteLength;///< 动画时长

//
@property (nonatomic) NSUInteger shadowCount;

+ (instancetype)itemWithDictionary:(NSDictionary *)dic;

@end
