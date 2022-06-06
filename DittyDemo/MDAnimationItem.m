//
//  MDAnimationItem.m
//  DittyDemo
//
//  Created by Zero.D.Saber on 04/05/2017.
//  Copyright © 2017 Zero.D.Saber. All rights reserved.
//

#import "MDAnimationItem.h"

@implementation MDAnimationItem

+ (instancetype)itemWithDictionary:(NSDictionary *)dic
{
    MDAnimationItem *item = [MDAnimationItem new];
    item.word = [dic objectForKey:@"word"];
    item.startTime = [[dic objectForKey:@"st"] doubleValue];
    item.endTime = [[dic objectForKey:@"et"] doubleValue];
    item.noteLength = [dic[@"noteLength"] doubleValue];
    return item;
}

-(void)dealloc
{
//    NSLog(@"%s",__func__);
}

@end
