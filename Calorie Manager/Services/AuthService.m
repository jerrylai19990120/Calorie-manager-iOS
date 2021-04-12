//
//  AuthService.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-11.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthService.h"

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

- (void)loginUser{
    
}

-(void)createUser{
    
}

@end
