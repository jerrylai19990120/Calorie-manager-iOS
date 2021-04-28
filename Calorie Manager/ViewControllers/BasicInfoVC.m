//
//  BasicInfoVC.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-19.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "BasicInfoVC.h"
#import "DataService.h"
#import "AuthService.h"
@import Firebase;

@interface BasicInfoVC ()

@end

@implementation BasicInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeyboard{
    [self.ageTxt resignFirstResponder];
    [self.heightTxt resignFirstResponder];
    [self.weightTxt resignFirstResponder];
}

- (IBAction)startBtnPressed:(id)sender {
    
    [AuthService.sharedInstance createUserWithEmail:self.email password:self.password username:self.username completion:^(BOOL *status) {
        if(self.ageTxt.text!=nil && self.heightTxt.text!=nil && self.weightTxt.text!=nil){
            [DataService.sharedInstance addBasicInfoWithAge:(NSNumber *)self.ageTxt.text height:(NSNumber *)self.heightTxt.text weight:(NSNumber *)self.weightTxt.text uid:[[[FIRAuth auth]currentUser]uid] completion:^(BOOL *status) {
                if(status){
                    [self performSegueWithIdentifier:@"HomePage" sender:self];
                }
            }];
        }
    }];
    
    
    
}

@end
