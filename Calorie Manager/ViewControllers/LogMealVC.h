//
//  LogMealVC.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-19.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LogMealVC : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *caloriesTxt;
@property (weak, nonatomic) IBOutlet UITextField *mealNameTxt;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *scroller;

@end

NS_ASSUME_NONNULL_END
