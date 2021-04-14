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

+ (instancetype)sharedInstance{
    
    static DataService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataService alloc]init];
    });
    
    return sharedInstance;
}





@end
