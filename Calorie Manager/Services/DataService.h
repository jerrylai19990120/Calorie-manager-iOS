//
//  DataService.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-13.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#ifndef DataService_h
#define DataService_h
@import Firebase;
#import "User.h"

@interface DataService : NSObject
+(instancetype)sharedInstance;
@property (strong, nonatomic) FIRDatabaseReference *ref;
- (void)createDBUserWithUid:(NSString *)uid dict:(NSDictionary *)dict;
- (void)addBasicInfoWithAge:(NSNumber *)age height:(NSNumber *)height weight:(NSNumber *)weight uid:(NSString *)uid completion:(void (^)(BOOL *status))completion;
-(NSDictionary *)getUserInfo;
+(User *)user;
@end

#endif /* DataService_h */
