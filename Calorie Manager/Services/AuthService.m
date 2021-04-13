//
//  AuthService.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-11.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthService.h"
@import Firebase;

@interface AuthService()
+ (instancetype)sharedInstance;
@end



@implementation AuthService

+ (instancetype)sharedInstance{
    static AuthService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)loginUserWithEmail:(NSString *)email password:(NSString *)password completion:(void (^)(BOOL *status))completion{
    [[FIRAuth auth] signInWithEmail:email password:password completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        if(error == nil){
            completion(true);
        }else{
            completion(false);
        }
    }];
}

-(void)createUserWithEmail:(NSString *)email password:(NSString *)password completion:(void (^)(BOOL *))completion{
    
    [[FIRAuth auth] createUserWithEmail:email password:password completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        if(error == nil){
            completion(true);
        }else{
            completion(false);
        }
    }];
}

@end
