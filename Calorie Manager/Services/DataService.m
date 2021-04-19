//
//  DataService.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-13.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataService.h"
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



@end
