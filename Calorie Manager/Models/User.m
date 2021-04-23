//
//  User.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-19.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithUid:(NSString *)uid username:(NSString *)username email:(NSString *)email age:(NSNumber *)age height:(NSNumber *)height weight:(NSNumber *)weight imgUrl:(nonnull NSString *)imgUrl{
    
    self = [super init];
    if(self){
        self.username = username;
        self.email = email;
        self.age = age;
        self.height = height;
        self.weight = weight;
        self.uid = uid;
        self.imgUrl = imgUrl;
    }
    return self;
    
}

- (int)getCaloriedNeededWithAge:(int)age weight:(int)weight height:(int)height{
    int calories = 66+6.23*weight+12.7*height-4.7*age;
    return calories;
}
@end
