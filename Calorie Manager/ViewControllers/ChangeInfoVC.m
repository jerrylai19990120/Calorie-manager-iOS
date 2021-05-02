//
//  ChangeInfoVC.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-05-02.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "ChangeInfoVC.h"
#import "DataService.h"

@interface ChangeInfoVC ()

@end

@implementation ChangeInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.spinner setHidden:true];
    [self.spinner stopAnimating];
    [self resetInputs];
    [self initValues];
}

- (IBAction)closeBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)updateBtnPressed:(id)sender {
    [self resetInputs];
    [self.spinner startAnimating];
    [self.spinner setHidden:false];
    
    if([self validateInputs]){
        [DataService.sharedInstance updateBasicInfoWithAge:self.ageTxt.text height:self.heightTxt.text weight:self.weightTxt.text completion:^(BOOL status) {
            NSDictionary *dict = @{
                @"age": self.ageTxt.text,
                @"height": self.heightTxt.text,
                @"weight": self.weightTxt.text
            };
            if(status){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeInfo" object:nil userInfo:dict];
                [self.spinner setHidden:true];
                [self.spinner stopAnimating];
                [self dismissViewControllerAnimated:true completion:nil];
            }else{
                self.weightErr.text = @"Unknown error";
                [self.weightErr setHidden:false];
                [self.spinner setHidden:true];
                [self.spinner stopAnimating];
            }
        }];
    }else{
        [self.spinner setHidden:true];
        [self.spinner stopAnimating];
    }
}

- (void)resetInputs{
    [self.weightErr setHidden:true];
    [self.heightErr setHidden:true];
    [self.ageErr setHidden:true];
}

- (void)initValues{
    self.ageTxt.text = self.age;
    self.weightTxt.text = self.weight;
    self.heightTxt.text = self.height;
}

- (BOOL)validateInputs{
    BOOL check = true;
    
    if([self.ageTxt.text isEqualToString:@""]){
        self.ageErr.text = @"cannot be empty";
        [self.ageErr setHidden:false];
        check = false;
    }
    
    if([self.heightTxt.text isEqualToString:@""]){
        self.heightErr.text = @"cannot be empty";
        [self.heightErr setHidden:false];
        check = false;
    }
    
    if([self.weightTxt.text isEqualToString:@""]){
        self.weightErr.text = @"cannot be empty";
        [self.weightErr setHidden:false];
        check = false;
    }
    
    return check;
}
@end
