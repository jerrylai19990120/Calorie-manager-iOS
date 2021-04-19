//
//  HomeTabBarVC.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-12.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeTabBarVC : UITabBarController

@property (nonatomic, strong) User *user;
@end

NS_ASSUME_NONNULL_END
