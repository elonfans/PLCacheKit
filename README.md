# PLCacheKit
目的：解决文件损坏导致的连续启动闪退问题

## 项目接入



### 1.连续闪退监控
```
// 缓存配置
PLCacheConfig *config = [[PLCacheConfig alloc] initWithCrashTimeout:3.0 crashCountWhenCleanNormalCache:2 crashCountWhenCleanSignificantCache:3];
// 开始启动闪退监控，根据配置自动清理损坏文件
[PLCacheMoniter startWithConfig:config];
```

### 2.规范缓存目录
```
// 注册缓存信息
BOOL success = [PLCacheDirectory registerForKey:testKey level:CacheLevelNormal pathType:CachePathTypeDocument relativeOriginPath:@"Documents/12345"];
NSLog(@"注册结果 %ld", (NSInteger)success);
// 根绝 Key 获取缓存相对路径
NSLog(@"path %@", [PLCacheDirectory pathForKey:testKey]);
```

## 核心业务逻辑

监控连续启动闪退次数，当达到 m1 次时清理非重要缓存文件，达到 m2 次时清理重要缓存文件以解决文件损坏导致的连续启动闪退问题。根据缓存重要性和是否业务下次启动所需，获取规范化的缓存目录，并且支持旧业务的缓存数据迁移。

## 相关类介绍

```
/*
 监控启动闪退次数，达到配置条件自动清理相应缓存目录
 */
#import "PLCacheMoniter.h"

/*
 规范缓存目录，维护缓存目录映射表
 */
#import "PLCacheDirectory.h"

/*
 缓存配置类
 */
#import "PLCacheConfig.h"

/*
 工具类
 */
#import "PLCacheTool.h"
```

## License

YTKNetwork is available under the MIT license. See the LICENSE file for more info.

