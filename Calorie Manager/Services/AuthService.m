//
//  AuthService.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-11.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthService.h"
#import "WelcomeVC.h"
#import "DataService.h"

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

- (void)loginUserWithEmail:(NSString *)email password:(NSString *)password completion:(void (^)(BOOL *, NSError * _Nullable))completion{
    [[FIRAuth auth] signInWithEmail:email password:password completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        if(error == nil){
            completion(true, nil);
        }else{
            completion(false, error);
        }
    }];
}

- (void)createUserWithEmail:(NSString *)email password:(NSString *)password username:(NSString *)username completion:(void (^)(BOOL *, NSError * _Nullable))completion{
    [[FIRAuth auth] createUserWithEmail:email password:password completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        if(error == nil){
            NSDictionary *dict = @{@"username": username, @"email": email};
            [DataService.sharedInstance createDBUserWithUid:authResult.user.uid dict:dict completion:^(BOOL status) {
                if(status){
                    completion(true, nil);
                }
            }];
        }else{
            completion(false, error);
        }
    }];
}

/*-(void)createUserWithEmail:(NSString *)email password:(NSString *)password username:(NSString *)username completion:(void (^)(BOOL *))completion errorFound:(void (^)(NSError * _Nullable))errorFound{
    
    [[FIRAuth auth] createUserWithEmail:email password:password completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        if(error == nil){
            NSDictionary *dict = @{@"username": username, @"email": email};
            [DataService.sharedInstance createDBUserWithUid:authResult.user.uid dict:dict completion:^(BOOL status) {
                if(status){
                    errorFound(nil);
                    completion(true);
                }
            }];
        }else{
            errorFound(error);
            completion(false);
        }
    }];
}*/

- (void)logoutUser{
    NSError *error;
    [[FIRAuth auth]signOut:&error];
    
    if(error != nil){
        NSLog(@"Sign out failed.");
    }
}

@end
