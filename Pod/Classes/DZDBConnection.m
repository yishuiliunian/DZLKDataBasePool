//
//  DZDBConnection.m
//  Pods
//
//  Created by stonedong on 16/11/13.
//
//

#import "DZDBConnection.h"
#import "DZFileUtils.h"
#import "NSString+MD5.h"

NSString* YHDBConnectionPathWithUID(NSString* uid) {
    NSString* dbPath = DZDocumentsSubPath(uid.MD5Digest);
    DZEnsurePathExist(dbPath);
    return  DZPathJoin(dbPath, @"message.db");
}

@implementation DZDBConnection
- (instancetype) initWithUID:(NSString *)uid
{
    self = [super init];
    if (!self) {
        return self;
    }
    _uid = uid;
    _dbhelper = [[LKDBHelper alloc] initWithDBPath:YHDBConnectionPathWithUID(_uid)];
    return self;
}

- (void) updateOrInsertObject:(id)object
{
    if ([_dbhelper isExistsModel:object]) {
        [_dbhelper updateToDB:object where:nil];
    } else {
        [_dbhelper insertToDB:object];
    }
}
@end
