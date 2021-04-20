//
//  Meal.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-19.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "Meal.h"

@implementation Meal

- (id)initWithName:(NSString *)name type:(NSString *)type calories:(NSNumber *)calories{
    
    self = [super init];
    if(self){
        self.mealName = name;
        self.mealType = type;
        self.calories = calories;
    }
    
    return self;
}

@end
