//
//  PLCacheTool.h
//  Demo
//
//  Created by pauley on 2018/4/8.
//  Copyright © 2018 pauley. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *cachePath = @"PLCacheKit";
static NSString *cacheNormal = @"Normal";
static NSString *cacheSignificant = @"Significant";
static NSString *cachePreferences = @"Preferences";

@interface PLCacheTool : NSObject

// 配置文件
+ (NSString *)plistFilePath;

@end
