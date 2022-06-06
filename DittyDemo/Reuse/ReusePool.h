//
//  ReuseObject.h
//  DittyDemo
//
//  Created by Zero.D.Saber on 2017/5/9.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PrepareForReuseProtocol <NSObject>
- (void)prepareForReuse;
@end

//--------------------------------------------

@interface ReusePool<__covariant ValueType> : NSObject

- (_Nullable ValueType)dequeueReusableCellWithIdentifier:(NSString *)identifier;

- (void)addReusePoolObject:(ValueType)object withIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
