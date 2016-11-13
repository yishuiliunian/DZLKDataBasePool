//
//  DZDBConnection.h
//  Pods
//
//  Created by stonedong on 16/11/13.
//
//

#import <Foundation/Foundation.h>
#import <LKDBHelper.h>
@interface DZDBConnection : NSObject
{
    @protected
    LKDBHelper* _dbhelper;
}
@property (nonatomic, strong, readonly) LKDBHelper* dbhelper;
@property (nonatomic, strong, readonly) NSString* uid;
- (instancetype) initWithUID:(NSString*)uid;
@end
