//
//  BasicInfoVC.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-19.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasicInfoVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *ageTxt;
@property (weak, nonatomic) IBOutlet UITextField *heightTxt;
@property (weak, nonatomic) IBOutlet UITextField *weightTxt;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *email;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *scroller;
@property (strong, nonatomic) NSString *password;
@end

NS_ASSUME_NONNULL_END
