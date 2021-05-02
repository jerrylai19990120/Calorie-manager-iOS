//
//  AddTaskVC.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-18.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddTaskVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *planName;
@property (weak, nonatomic) IBOutlet UITextField *planLength;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *scroller;
- (void)resetInputs;
- (BOOL)validateInputs;
@property (weak, nonatomic) IBOutlet UILabel *nameErr;
@property (weak, nonatomic) IBOutlet UILabel *daysErr;
@property (weak, nonatomic) IBOutlet UIView *nameLine;

@end

NS_ASSUME_NONNULL_END
