//
//  User.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-19.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithUid:(NSString *)uid username:(NSString *)username email:(NSString *)email age:(NSNumber *)age height:(NSNumber *)height weight:(NSNumber *)weight{
    
    self = [super init];
    if(self){
        self.username = username;
        self.email = email;
        self.age = age;
        self.height = height;
        self.weight = weight;
        self.uid = uid;
        
    }
    return self;
    
}



@end
