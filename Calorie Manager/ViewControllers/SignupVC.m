//
//  SignupVC.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-07.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "SignupVC.h"
#import "AuthService.h"
#import "BasicInfoVC.h"

@interface SignupVC ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTxt;
@property (weak, nonatomic) IBOutlet UITextField *emailTxt;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;

@end

@implementation SignupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)backBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)signupBtnPressed:(id)sender {
    AuthService *instance = [AuthService sharedInstance];
    
    [instance createUserWithEmail:self.emailTxt.text password:self.password.text username:self.usernameTxt.text completion:^(BOOL *status) {
        if(status){
            BasicInfoVC *infoVC = [[BasicInfoVC alloc]init];
            [self presentViewController:infoVC animated:true completion:nil];
        }
    }];
}


@end
