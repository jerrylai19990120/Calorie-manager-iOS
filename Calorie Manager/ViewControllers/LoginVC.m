//
//  LoginVC.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-07.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "LoginVC.h"
#import "AuthService.h"

@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *emailTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    [self.scroller setHidden:true];
    [self.scroller stopAnimating];
    [self.emailErrTxt setHidden:true];
    [self.passwordErrTxt setHidden:true];
}

- (void)dismissKeyboard{
    [self.emailTxt resignFirstResponder];
    [self.passwordTxt resignFirstResponder];
}

- (IBAction)backBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)loginBtnPressed:(id)sender {
    self.emailLine.backgroundColor = [UIColor colorNamed:@"mainColor"];
    self.passwordLine.backgroundColor = [UIColor colorNamed:@"mainColor"];
    [self.emailErrTxt setHidden:true];
    [self.passwordErrTxt setHidden:true];
    AuthService *instance = [AuthService sharedInstance];
    [self.scroller startAnimating];
    [self.scroller setHidden:false];
    [instance loginUserWithEmail:self.emailTxt.text password:self.passwordTxt.text completion:^(BOOL *status, NSError * _Nullable err) {
        if(err==nil){
            if(status){
                [self.scroller setHidden:true];
                [self.scroller stopAnimating];
                [self performSegueWithIdentifier:@"HomeVC" sender:self];
            }else{
                [self.scroller setHidden:true];
                [self.scroller stopAnimating];
            }
        }else{
            [self.scroller setHidden:true];
            [self.scroller stopAnimating];
            [self validateAuthInputWithErr:err];
        }
        
    }];
    
}

- (void)validateAuthInputWithErr:(NSError *)err{
    if([err.userInfo[@"FIRAuthErrorUserInfoNameKey"] isEqualToString:@"ERROR_WRONG_PASSWORD"]){
        self.passwordLine.backgroundColor = [UIColor colorNamed:@"errColor"];
        [self.passwordErrTxt setHidden:false];
    }else{
        self.emailLine.backgroundColor = [UIColor colorNamed:@"errColor"];
        [self.emailErrTxt setHidden:false];
    }
}

@end
