//
//  PLCacheDirectory.h
//  Demo
//
//  Created by pauley on 2018/4/8.
//  Copyright © 2018 pauley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLCacheKit.h"

@interface PLCacheDirectory : NSObject

/*
 注册缓存信息
 
 key：缓存 key，根据 key 可获取缓存目录
 level：缓存级别
 pathType：缓存目录类型
 originPath：原业务缓存地址，如果没有则传 nil
 */
+ (BOOL)registerForKey:(NSString *)key level:(CacheLevel)level pathType:(CachePathType)pathType relativeOriginPath:(NSString *)relativeOriginPath;

/*
 根据缓存 key 获取缓存目录，如果没有注册，返回 nil
 */
+ (NSURL *)pathForKey:(NSString *)key;

@end
