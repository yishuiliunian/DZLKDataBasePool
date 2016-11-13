//
//  DZDBConnectionPool.h
//  Pods
//
//  Created by stonedong on 16/11/13.
//
//

#import <Foundation/Foundation.h>
#import "DZDBConnection.h"
@interface DZDBConnectionPool : NSObject
+ (DZDBConnectionPool*) sharePool;
- (DZDBConnection*) connectionWithUID:(NSString*)uid;
+ (DZDBConnection*) shareCacheConnection;
- (void) registerConnectionClass:(Class)cla;

@end
