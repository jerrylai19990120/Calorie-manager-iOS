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

@interface DataService : NSObject
+(instancetype)sharedInstance;
@property (strong, nonatomic) FIRDatabaseReference *ref;
- (void)createDBUserWithUid:(NSString *)uid dict:(NSDictionary *)dict;
@end

#endif /* DataService_h */
