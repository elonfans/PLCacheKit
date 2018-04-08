//
//  PLCacheConfig.m
//  Demo
//
//  Created by pauley on 2018/4/8.
//  Copyright © 2018 pauley. All rights reserved.
//

#import "PLCacheConfig.h"

@implementation PLCacheConfig

- (id)initWithCrashTimeout:(NSTimeInterval)crashTimeout crashCountWhenCleanNormalCache:(NSInteger)crashCountWhenCleanNormalCache crashCountWhenCleanSignificantCache:(NSInteger)crashCountWhenCleanSignificantCache
{
    if (self = [super init]) {
        self.crashTimeout = crashTimeout;
        self.crashCountWhenCleanNormalCache = crashCountWhenCleanNormalCache;
        self.crashCountWhenCleanSignificantCache = crashCountWhenCleanSignificantCache;
    }
    return self;
}

@end
