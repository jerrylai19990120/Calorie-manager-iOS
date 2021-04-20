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

@property (assign) NSString *username;
@property (assign) NSString *email;
@property (assign) NSNumber *age;
@property (assign) NSNumber *height;
@property (assign) NSNumber *weight;
@property (assign) NSNumber *calorieBudget;
@property (nonatomic, strong) NSString *uid;
- (id) initWithUid:(NSString *)uid username:(NSString *)username email:(NSString *)email age:(NSNumber *)age height:(NSNumber *)height weight:(NSNumber *)weight;


@end

NS_ASSUME_NONNULL_END
