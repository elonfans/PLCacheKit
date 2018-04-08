//
//  PLCacheTool.m
//  Demo
//
//  Created by pauley on 2018/4/8.
//  Copyright © 2018 pauley. All rights reserved.
//

#import "PLCacheTool.h"

@implementation PLCacheTool

+ (NSString *)plistFilePath
{
    return [[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:cachePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", cachePath]];
}

@end
