//
//  User.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-19.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSNumber *age;
@property (strong, nonatomic) NSNumber *height;
@property (strong, nonatomic) NSNumber *weight;
@property (strong, nonatomic) NSNumber *calorieBudget;
@property (strong, nonatomic) NSString *imgUrl;
@property (nonatomic, strong) NSString *uid;
- (id) initWithUid:(NSString *)uid username:(NSString *)username email:(NSString *)email age:(NSNumber *)age height:(NSNumber *)height weight:(NSNumber *)weight imgUrl:(NSString *)imgUrl;

- (int)getCaloriedNeededWithAge:(int)age weight:(int)weight height:(int)height;
@end

NS_ASSUME_NONNULL_END
