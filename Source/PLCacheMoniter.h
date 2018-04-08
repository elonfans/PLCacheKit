//
//  PLCacheMoniter.h
//  Demo
//
//  Created by pauley on 2018/4/8.
//  Copyright © 2018 pauley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLCacheConfig.h"

// 缓存等级
typedef NS_ENUM(NSUInteger, CacheLevel) {
    CacheLevelNormal = 1,
    CacheLevelSignificant,
};

// 缓存路径类别
typedef NS_ENUM(NSUInteger, CachePathType) {
    CachePathTypeDocument = 1,
    CachePathTypeLibraryPreferences,
    CachePathTypeLibraryCache,
    CachePathTypeTemp,
};

@interface PLCacheMoniter : NSObject

/*
 启动
 appId：应用id
 config：配置信息
 */
+ (void)startWithConfig:(PLCacheConfig *)config;

@end
