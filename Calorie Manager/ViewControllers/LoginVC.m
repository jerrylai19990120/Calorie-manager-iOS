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
}

- (void)dismissKeyboard{
    [self.emailTxt resignFirstResponder];
    [self.passwordTxt resignFirstResponder];
}

- (IBAction)backBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)loginBtnPressed:(id)sender {
    AuthService *instance = [AuthService sharedInstance];
    [self.scroller startAnimating];
    [self.scroller setHidden:false];
    [instance loginUserWithEmail:self.emailTxt.text password:self.passwordTxt.text completion:^(BOOL *status) {
        if(status){
            [self.scroller setHidden:true];
            [self.scroller stopAnimating];
            [self performSegueWithIdentifier:@"HomeVC" sender:self];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
