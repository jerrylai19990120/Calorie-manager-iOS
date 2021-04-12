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
- (void)loginUser;
- (void)createUser;
@end

#endif /* AuthService_h */
