//
//  PLCacheConfig.h
//  Demo
//
//  Created by pauley on 2018/4/8.
//  Copyright © 2018 pauley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLCacheConfig : NSObject

// 超时时间，默认5秒，如果超过5秒没有启动闪退，则认为正常启动
@property (nonatomic, assign) NSTimeInterval crashTimeout;

// 连续启动闪退多次清理普通缓存，默认2次
@property (nonatomic, assign) NSInteger crashCountWhenCleanNormalCache;

// 连续启动闪退多次清理重要缓存，默认3次
@property (nonatomic, assign) NSInteger crashCountWhenCleanSignificantCache;

- (id)initWithCrashTimeout:(NSTimeInterval)crashTimeout crashCountWhenCleanNormalCache:(NSInteger)crashCountWhenCleanNormalCache crashCountWhenCleanSignificantCache:(NSInteger)crashCountWhenCleanSignificantCache;

@end
