//
//  Plan.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-19.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "Plan.h"

@implementation Plan

- (id)initWithTitle:(NSString *)title progress:(NSNumber *)progress goalDays:(NSNumber *)goalDays uid:(NSString *)uid{
        
    self = [super init];
    if(self){
        self.title = title;
        self.progress = progress;
        self.goalDays = goalDays;
        self.uid = uid;
    }
    
    return self;
}

@end
