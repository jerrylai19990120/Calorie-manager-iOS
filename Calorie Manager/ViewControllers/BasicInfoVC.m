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
    [self.scroller setHidden:true];
    [self.scroller stopAnimating];
    [self resetInputs];
}

- (void)dismissKeyboard{
    [self.ageTxt resignFirstResponder];
    [self.heightTxt resignFirstResponder];
    [self.weightTxt resignFirstResponder];
}

- (IBAction)startBtnPressed:(id)sender {
    [self resetInputs];
    [self.scroller startAnimating];
    [self.scroller setHidden:false];
    
    if([self validateInputs]){
        [AuthService.sharedInstance createUserWithEmail:self.email password:self.password username:self.username completion:^(BOOL *status, NSError * _Nullable err) {
            
                [DataService.sharedInstance addBasicInfoWithAge:(NSNumber *)self.ageTxt.text height:(NSNumber *)self.heightTxt.text weight:(NSNumber *)self.weightTxt.text uid:[[[FIRAuth auth]currentUser]uid] completion:^(BOOL *status) {
                    if(status){
                        [self.scroller setHidden:true];
                        [self.scroller stopAnimating];
                        [self performSegueWithIdentifier:@"HomePage" sender:self];
                    }else{
                        [self.scroller setHidden:true];
                        [self.scroller stopAnimating];
                    }
                }];
            }];
    }else{
        [self.scroller setHidden:true];
        [self.scroller stopAnimating];
    }
    
    
    
    
}

- (void)resetInputs{
    [self.ageErr setHidden:true];
    self.ageLine.backgroundColor = [UIColor colorNamed:@"mainColor"];
    [self.heightErr setHidden:true];
    self.heightLine.backgroundColor = [UIColor colorNamed:@"mainColor"];
    [self.weightErr setHidden:true];
    self.weightLine.backgroundColor = [UIColor colorNamed:@"mainColor"];
}

- (BOOL)validateInputs{
    
    BOOL check = true;
    
    if([self.ageTxt.text isEqualToString:@""]){
        self.ageErr.text = @"Cannot be empty";
        [self.ageErr setHidden:false];
        self.ageLine.backgroundColor = [UIColor colorNamed:@"errColor"];
        check = false;
    }
    
    if([self.heightTxt.text isEqualToString:@""]){
        self.heightErr.text = @"Cannot be empty";
        [self.heightErr setHidden:false];
        self.heightLine.backgroundColor = [UIColor colorNamed:@"errColor"];
        check = false;
    }
    
    if([self.weightTxt.text isEqualToString:@""]){
        self.weightErr.text = @"Cannot be empty";
        [self.weightErr setHidden:false];
        self.weightLine.backgroundColor = [UIColor colorNamed:@"errColor"];
        check = false;
    }
    
    return check;
}

@end
