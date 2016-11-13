//
//  DZDBConnectionPool.m
//  Pods
//
//  Created by stonedong on 16/11/13.
//
//

#import "DZDBConnectionPool.h"
#import "DZDBConnection.h"
@interface DZDBConnectionPool()
{
    NSMutableDictionary* _connectionCache;
    NSRecursiveLock* _lock;
}
@property (nonatomic, strong) Class connectioClass;
@end
@implementation DZDBConnectionPool

- (void) registerConnectionClass:(Class)cla
{
    self.connectioClass = cla;
}

+ (DZDBConnectionPool*) sharePool
{
    static DZDBConnectionPool* pool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pool =[DZDBConnectionPool new];
    });
    return pool;
}

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _connectionCache = [NSMutableDictionary new];
    _lock = [[NSRecursiveLock alloc]init];
    return self;
}

- (DZDBConnectionPool*) connectionWithUID:(NSString *)uid
{
    if (!uid) {
        return nil;
    }
    [_lock lock];

    DZDBConnection* connection = _connectionCache[uid];
    if (!connection) {
        connection = [[self.connectioClass alloc] initWithUID:uid];
        _connectionCache[uid] = connection;
    }
    [_lock unlock];
    return connection;
}

+ (DZDBConnection*) shareCacheConnection
{
    return [[self sharePool] connectionWithUID:@"ShareFetcherCache"];
}
@end
