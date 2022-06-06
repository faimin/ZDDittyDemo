//
//  ReuseObject.m
//  DittyDemo
//
//  Created by Zero.D.Saber on 2017/5/9.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

/**
 一种重用id对应一个对象集合
 */

#import "ReusePool.h"

@interface ReusePool ()
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSSet *> *reusePool;
@end

@implementation ReusePool

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    NSParameterAssert(identifier);
    
    if (!identifier) return nil;
    
    id value;
    if ([self.reusePool.allKeys containsObject:identifier]) {
        NSMutableSet *valueSet = (id)[self.reusePool valueForKey:identifier];
        value = [valueSet anyObject];
        if (value) {
            [valueSet removeObject:value];
        }
        
        if ([value conformsToProtocol:@protocol(PrepareForReuseProtocol)] && [value respondsToSelector:@selector(prepareForReuse)]) {
            [value prepareForReuse];
        }
    }
    return value;
}

- (void)addReusePoolObject:(id)object withIdentifier:(NSString *)identifier {
    if (!object || !identifier) return;
    
    NSMutableSet *mutSet = (id)[self.reusePool valueForKey:identifier];
    if (mutSet) {
        [mutSet addObject:object];
        [self.reusePool setValue:mutSet forKey:identifier];
    }
    else {
        mutSet = [NSMutableSet setWithObject:object];
        [self.reusePool setValue:mutSet forKey:identifier];
    }
}

- (id)getValue:(NSString *)identifier {
    Class aClass = NSClassFromString(identifier);
    id value;
    if (aClass) {
        value = [aClass new];
        NSMutableSet *mutSet = [NSMutableSet setWithObject:value];
        [self.reusePool setValue:mutSet forKey:identifier];
    }
    return value;
}

#pragma mark - Property
// Getter
- (NSMutableDictionary<NSString *, NSSet *> *)reusePool {
    if (!_reusePool) {
        _reusePool = @{}.mutableCopy;
    }
    return _reusePool;
}

@end
