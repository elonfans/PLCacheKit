//
//  PLCacheDirectory.m
//  Demo
//
//  Created by pauley on 2018/4/8.
//  Copyright © 2018 pauley. All rights reserved.
//

#import "PLCacheDirectory.h"
#import "PLCacheTool.h"

@implementation PLCacheDirectory


+ (BOOL)registerForKey:(NSString *)key level:(CacheLevel)level pathType:(CachePathType)pathType relativeOriginPath:(NSString *)relativeOriginPath
{
    if (![[self class] pathForKey:key]) {
        
        NSString *filePath = [[self class] fullPathForKey:key level:level pathType:pathType];
        
        if (relativeOriginPath) {
            // 原目录迁移
            NSString *mainPath = [NSHomeDirectory() stringByAppendingPathComponent:[[self class] mainPathForKey:key level:level pathType:pathType]];
            if (![[NSFileManager defaultManager] fileExistsAtPath:mainPath]) {
                NSError *error = nil;
                BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:mainPath withIntermediateDirectories:YES attributes:nil error:&error];
                if (!success) {
                    return NO;
                }
            }
            
            NSString *fullOriginPath = [NSHomeDirectory() stringByAppendingPathComponent:relativeOriginPath];
            NSError *err;
            BOOL moveSuccess = [[NSFileManager defaultManager] moveItemAtPath:fullOriginPath toPath:filePath error:&err];
            if (!moveSuccess) {
                return NO;
            }
        } else {
            // 无需迁移，则创建新目录
            if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
                BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:nil attributes:nil error:nil];
                if (!success) {
                    return NO;
                }
            }
        }
        
        // 注册缓存信息
        NSString *relativePath = [[self class] relativePathForKey:key level:level pathType:pathType];
        return [[self class] saveCacheMapWithKey:key path:relativePath level:level];
    } else {
        return YES;
    }
}

+ (NSString *)pathForKey:(NSString *)key
{
    NSString *plistFilePath = [PLCacheTool plistFilePath];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistFilePath]) {
        dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFilePath];
    }
    
    NSString *normalPath = [[dic objectForKey:[[self class] levelString:CacheLevelNormal]] objectForKey:key];
    NSString *significantPath = [[dic objectForKey:[[self class] levelString:CacheLevelSignificant]] objectForKey:key];
    
    if (normalPath.length > 0) {
        return normalPath;
    }
    
    if (significantPath.length > 0) {
        return significantPath;
    }
    
    return nil;
}

#pragma mark - private

+ (NSString *)fullPathForKey:(NSString *)key level:(CacheLevel)level pathType:(CachePathType)pathType;
{
    return [NSHomeDirectory() stringByAppendingPathComponent:[[self class] relativePathForKey:key level:level pathType:pathType]];
}

+ (NSString *)relativePathForKey:(NSString *)key level:(CacheLevel)level pathType:(CachePathType)pathType
{
    NSString *relativePath = [[self class] mainPathForKey:key level:level pathType:pathType];
    
    relativePath = [relativePath stringByAppendingPathComponent:key];
    
    return relativePath;
}

+ (NSString *)mainPathForKey:(NSString *)key level:(CacheLevel)level pathType:(CachePathType)pathType
{
    NSString *mainPath;
    
    switch (pathType) {
        case CachePathTypeDocument:
            mainPath = @"Documents";
            break;
        case CachePathTypeLibraryPreferences:
            mainPath = @"Library/Preferences";
            break;
        case CachePathTypeLibraryCache:
            mainPath = @"Library/Cache";
            break;
        case CachePathTypeTemp:
            mainPath = @"Temp";
            break;
    }
    
    mainPath = [mainPath stringByAppendingPathComponent:cachePath];
    
    switch (level) {
        case CacheLevelNormal:
            mainPath = [mainPath stringByAppendingPathComponent:@"Normal"];
            break;
        case CacheLevelSignificant:
            mainPath = [mainPath stringByAppendingPathComponent:@"Significant"];
            break;
    }
    
    return mainPath;
}

+ (BOOL)saveCacheMapWithKey:(NSString *)key path:(NSString *)path level:(CacheLevel)level
{
    NSString *plistFilePath = [[self class] plistFilePath];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistFilePath]) {
        dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFilePath];
    }
    
    NSMutableDictionary *levelDic = [[NSMutableDictionary alloc] initWithDictionary:[dic objectForKey:[[self class] levelString:level]]];
    [levelDic setObject:path forKey:key];
    
    [dic setObject:levelDic forKey:[[self class] levelString:level]];
    
    return [dic writeToFile:plistFilePath atomically:YES];
}

+ (NSString *)levelString:(CacheLevel)level
{
    switch (level) {
        case CacheLevelNormal:
            return cacheNormal;
            break;
            
        case CacheLevelSignificant:
            return cacheSignificant;
            break;
    }
}

@end
