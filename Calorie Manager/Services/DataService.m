//
//  DataService.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-13.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataService.h"
#import "User.h"
@import Firebase;

@interface DataService()

@end


@implementation DataService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ref = nil;
        self.ref = [[FIRDatabase database]reference];
    }
    return self;
}

+ (instancetype)sharedInstance{
    
    static DataService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataService alloc]init];
    });
    
    return sharedInstance;
}

- (void)createDBUserWithUid:(NSString *)uid dict:(NSDictionary *)dict{
    [[[self.ref child:@"users"]child:uid]updateChildValues:dict];
}

- (void)addBasicInfoWithAge:(NSNumber *)age height:(NSNumber *)height weight:(NSNumber *)weight uid:(NSString *)uid completion:(void (^)(BOOL *))completion{
    if(age==nil || height==nil || weight==nil){
        completion(false);
    }else{
        [[[[self.ref child:@"users"]child:uid]child:@"age"]setValue:age];
        [[[[self.ref child:@"users"]child:uid]child:@"height"]setValue:height];
        [[[[self.ref child:@"users"]child:uid]child:@"weight"]setValue:weight];
        completion(true);
    }
}

- (NSDictionary *)getUserInfo{
    
    __block NSDictionary *dict = nil;
    
    [[[self.ref child:@"users"]child:[[[FIRAuth auth]currentUser]uid]]getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nonnull snapshot) {
        if(error==nil){
            
            
        }
    }];
    NSLog(@"%@", dict);
    return dict;
}

+ (void)userWithCompletion:(void (^)(User *))completion{
    
    [[[DataService.sharedInstance.ref child:@"users"]child:[[[FIRAuth auth]currentUser]uid]]getDataWithCompletionBlock:^(NSError * _Nullable error, FIRDataSnapshot * _Nonnull snapshot) {
        if(error==nil){
            User *user = [[User alloc]initWithUid:[FIRAuth auth].currentUser.uid username:snapshot.value[@"username"] email:snapshot.value[@"email"] age:(NSNumber *)snapshot.value[@"age"] height:(NSNumber *)snapshot.value[@"height"] weight:(NSNumber *)snapshot.value[@"weight"]];
            completion(user);
        }else{
            completion(nil);
        }
    }];
}

@end
