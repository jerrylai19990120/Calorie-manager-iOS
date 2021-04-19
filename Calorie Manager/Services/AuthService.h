//
//  AuthService.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-11.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#ifndef AuthService_h
#define AuthService_h


@interface AuthService: NSObject
+ (instancetype)sharedInstance;
- (void)loginUserWithEmail:(NSString *)email password:(NSString *)password completion:(void (^)(BOOL *status))completion;
- (void)createUserWithEmail:(NSString *)email password:(NSString *)password username:(NSString *)username completion:(void (^)(BOOL *status))completion;
- (void)logoutUser;
@end

#endif /* AuthService_h */
