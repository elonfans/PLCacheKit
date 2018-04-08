//
//  PLCacheMoniter.m
//  Demo
//
//  Created by pauley on 2018/4/8.
//  Copyright © 2018 pauley. All rights reserved.
//

#import "PLCacheMoniter.h"
#import "PLCacheTool.h"

@implementation PLCacheMoniter

+ (void)startWithConfig:(PLCacheConfig *)config
{
    NSInteger crashCount = [[self class] crashCount];
    if (crashCount >= config.crashCountWhenCleanSignificantCache) {
        [[self class] cleanSignificantCache];
        [[self class] removeSignificantKeyPathMap];
        [[self class] updateCrashCount:0];
    } else if (crashCount >= config.crashCountWhenCleanNormalCache) {
        [[self class] cleanNormalCache];
        [[self class] removeNormalKeyPathMap];
    }
    
    [[self class] updateCrashCount:crashCount + 1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(config.crashTimeout * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[self class] updateCrashCount:0];
    });
}

+ (NSInteger)crashCount;
{
    NSString *plistFilePath = [PLCacheTool plistFilePath];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistFilePath]) {
        dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFilePath];
    }
    
    return [[dic objectForKey:@"crashCount"] integerValue];
}

+ (BOOL)updateCrashCount:(NSInteger)crashCount
{
    NSString *plistFilePath = [PLCacheTool plistFilePath];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistFilePath]) {
        dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFilePath];
    }
    
    [dic setObject:@(crashCount) forKey:@"crashCount"];
    
    return [dic writeToFile:plistFilePath atomically:YES];
}

+ (BOOL)removeNormalKeyPathMap
{
    NSString *plistFilePath = [[self class] plistFilePath];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistFilePath]) {
        dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFilePath];
    }
    
    [dic removeObjectForKey:cacheNormal];
    
    return [dic writeToFile:plistFilePath atomically:YES];
}

+ (BOOL)removeSignificantKeyPathMap
{
    NSString *plistFilePath = [[self class] plistFilePath];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistFilePath]) {
        dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFilePath];
    }
    
    [dic removeObjectForKey:cacheSignificant];
    
    return [dic writeToFile:plistFilePath atomically:YES];
}

+ (void)cleanNormalCache
{
    NSString *documentNormalPath = [[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:cachePath] stringByAppendingPathComponent:cacheNormal];
    [[NSFileManager defaultManager] removeItemAtPath:documentNormalPath error:nil];
    
    NSString *libraryPreferencesNormalPath = [[[[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:cachePreferences] stringByAppendingPathComponent:cachePath] stringByAppendingPathComponent:cacheNormal];
    [[NSFileManager defaultManager] removeItemAtPath:libraryPreferencesNormalPath error:nil];
    
    NSString *libraryCacheNormalPath = [[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:cachePath] stringByAppendingPathComponent:cacheNormal];
    [[NSFileManager defaultManager] removeItemAtPath:libraryCacheNormalPath error:nil];
    
    NSString *tempNormalPath = [[NSTemporaryDirectory() stringByAppendingPathComponent:cachePath] stringByAppendingPathComponent:cacheNormal];
    [[NSFileManager defaultManager] removeItemAtPath:tempNormalPath error:nil];
}

+ (void)cleanSignificantCache
{
    NSString *documentSignificantPath = [[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:cachePath] stringByAppendingPathComponent:cacheSignificant];
    [[NSFileManager defaultManager] removeItemAtPath:documentSignificantPath error:nil];
    
    NSString *libraryPreferencesSignificantPath  = [[[[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:cachePreferences] stringByAppendingPathComponent:cachePath] stringByAppendingPathComponent:cacheSignificant];;
    [[NSFileManager defaultManager] removeItemAtPath:libraryPreferencesSignificantPath error:nil];
    
    NSString *libraryCacheSignificantPath = [[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:cachePath] stringByAppendingPathComponent:cacheSignificant];
    [[NSFileManager defaultManager] removeItemAtPath:libraryCacheSignificantPath error:nil];
    
    NSString *tempSignificantPath = [[NSTemporaryDirectory() stringByAppendingPathComponent:cachePath] stringByAppendingPathComponent:cacheSignificant];
    [[NSFileManager defaultManager] removeItemAtPath:tempSignificantPath error:nil];
}

@end
