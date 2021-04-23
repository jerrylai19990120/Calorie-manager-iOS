//
//  Meal.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-19.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Meal : NSObject
@property (assign) NSString *mealName;
@property (assign) NSNumber *calories;
@property (assign) NSString *mealType;
@property (assign) NSString *date;
- (id)initWithName:(NSString *)name type:(NSString *)type calories:(NSNumber *)calories date:(NSString *)date;
@end

NS_ASSUME_NONNULL_END
