//
//  Plan.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-19.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Plan : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *goalDays;
@property (strong, nonatomic) NSNumber *progress;
@property (strong, nonatomic) NSString *uid;
- (id)initWithTitle:(NSString *)title progress:(NSNumber *)progress goalDays:(NSNumber *)goalDays uid:(NSString *)uid;
@end

NS_ASSUME_NONNULL_END
