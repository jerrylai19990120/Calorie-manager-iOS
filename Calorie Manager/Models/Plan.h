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
@property (assign) NSString *title;
@property (assign) NSNumber *goalDays;
@property (assign) NSNumber *progress;
- (id)initWithTitle:(NSString *)title progress:(NSNumber *)progress goalDays:(NSNumber *)goalDays;
@end

NS_ASSUME_NONNULL_END
