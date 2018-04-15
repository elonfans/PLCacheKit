# PLCacheKit

## Abstract

To solve the problem of continuous startup crash caused by file damage.

## Support 

iOS 6.0+

## Usage

#### 1. continuous crash monitoring
```
// Cache Config
PLCacheConfig *config = [[PLCacheConfig alloc] initWithCrashTimeout:3.0 crashCountWhenCleanNormalCache:2 crashCountWhenCleanSignificantCache:3];
// Start Crash Monitoring, Clean Up The Corrupted Files According To The Configuration
[PLCacheMoniter startWithConfig:config];
```

#### 2. Standard Cache Directory
```
// Register Cache Info
BOOL success = [PLCacheDirectory registerForKey:testKey level:CacheLevelNormal pathType:CachePathTypeDocument relativeOriginPath:@"Documents/12345"];
NSLog(@"Regisstration results %ld", (NSInteger)success);
// Get Cache Relative Path
NSLog(@"path %@", [PLCacheDirectory pathForKey:testKey]);
```

## Core Logic

Monitor the numbser of continuous startup crash, clean non-important cache files or importance cache files according to the number of startup crash.

Get the normalized cache directory based on the cache importance and support the cache data migration of the old business.

## Related Class

```
/*
Monitor the numbser of continuous startup crash
 */
#import "PLCacheMoniter.h"

/*
Standardize the cache directory and maintain the cache directory mapping plist file
 */
#import "PLCacheDirectory.h"
 
/*
Cache Configuration
 */
#import "PLCacheConfig.h"

/*
Tool Class
 */
#import "PLCacheTool.h"
```

## License

PLCacheKit is available under the MIT license. See the LICENSE file for more info.

## Contact

Email : pauleyliu@gmail.com

