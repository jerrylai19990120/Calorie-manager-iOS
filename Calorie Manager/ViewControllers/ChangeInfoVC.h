//
//  ChangeInfoVC.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-05-02.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangeInfoVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *weightTxt;
@property (weak, nonatomic) IBOutlet UITextField *heightTxt;
@property (weak, nonatomic) IBOutlet UITextField *ageTxt;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UILabel *weightErr;
@property (weak, nonatomic) IBOutlet UILabel *heightErr;
@property (weak, nonatomic) IBOutlet UILabel *ageErr;
@property (strong, nonatomic) NSString *age;
@property (strong, nonatomic) NSString *height;
@property (strong, nonatomic) NSString *weight;
- (void)resetInputs;
- (void)initValues;
- (BOOL)validateInputs;
@end

NS_ASSUME_NONNULL_END
