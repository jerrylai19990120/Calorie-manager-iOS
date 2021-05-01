//
//  SignupVC.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-07.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignupVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *usernameErr;
@property (weak, nonatomic) IBOutlet UILabel *emailErr;
@property (weak, nonatomic) IBOutlet UILabel *passwordErr;
@property (weak, nonatomic) IBOutlet UILabel *confirmErr;
@property (weak, nonatomic) IBOutlet UIView *usernameLine;
@property (weak, nonatomic) IBOutlet UIView *emailLine;
@property (weak, nonatomic) IBOutlet UIView *passwordLine;
@property (weak, nonatomic) IBOutlet UIView *confirmLine;

- (BOOL)validateInputs;
- (void)resetInputs;
@end

NS_ASSUME_NONNULL_END
