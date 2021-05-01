//
//  LoginVC.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-07.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginVC : UIViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *scroller;
- (void)validateAuthInputWithErr:(NSError * _Nullable)err;
@property (weak, nonatomic) IBOutlet UILabel *emailErrTxt;
@property (weak, nonatomic) IBOutlet UILabel *passwordErrTxt;
@property (weak, nonatomic) IBOutlet UIView *passwordLine;
@property (weak, nonatomic) IBOutlet UIView *emailLine;

@end

NS_ASSUME_NONNULL_END
