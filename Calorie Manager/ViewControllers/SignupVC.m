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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    [self resetInputs];
}

- (void)dismissKeyboard{
    [self.usernameTxt resignFirstResponder];
    [self.emailTxt resignFirstResponder];
    [self.password resignFirstResponder];
    [self.confirmPassword resignFirstResponder];
}

- (IBAction)backBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)signupBtnPressed:(id)sender {
    [self resetInputs];
    BOOL validated = [self validateInputs];
    if(validated){
        [self performSegueWithIdentifier:@"BasicInfo" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqual: @"BasicInfo"]){
        BasicInfoVC *infoVC = segue.destinationViewController;
        infoVC.username = self.usernameTxt.text;
        infoVC.email = self.emailTxt.text;
        infoVC.password = self.password.text;
    }
}

- (void)resetInputs{
    [self.usernameErr setHidden:true];
    self.usernameLine.backgroundColor = [UIColor colorNamed:@"mainColor"];
    [self.emailErr setHidden:true];
    self.emailLine.backgroundColor = [UIColor colorNamed:@"mainColor"];
    [self.passwordErr setHidden:true];
    self.passwordLine.backgroundColor = [UIColor colorNamed:@"mainColor"];
    [self.confirmErr setHidden:true];
    self.confirmLine.backgroundColor = [UIColor colorNamed:@"mainColor"];
}

- (BOOL)validateInputs{
    
    BOOL check = true;
    
    if([self.emailTxt.text isEqualToString:@""]){
        self.emailLine.backgroundColor = [UIColor colorNamed:@"errColor"];
        self.emailErr.text = @"Cannot be empty";
        [self.emailErr setHidden:false];
        check = false;
    }
    
    if([self.password.text isEqualToString:@""]){
        self.passwordLine.backgroundColor = [UIColor colorNamed:@"errColor"];
        self.passwordErr.text = @"Cannot be empty";
        [self.passwordErr setHidden:false];
        check = false;
    }
    
    if([self.confirmPassword.text isEqualToString:@""]){
        self.confirmLine.backgroundColor = [UIColor colorNamed:@"errColor"];
        self.confirmErr.text = @"Cannot be empty";
        [self.confirmErr setHidden:false];
        check = false;
    }
    
    if([self.usernameTxt.text isEqualToString:@""]){
        self.usernameLine.backgroundColor = [UIColor colorNamed:@"errColor"];
        self.usernameErr.text = @"Cannot be empty";
        [self.usernameErr setHidden:false];
        check = false;
    }
    
    if(![self.password.text isEqualToString:self.confirmPassword.text]){
        self.confirmLine.backgroundColor = [UIColor colorNamed:@"errColor"];
        self.confirmErr.text = @"Password doesn't match";
        [self.confirmErr setHidden:false];
        check = false;
    }
        
    return check;
}

@end
