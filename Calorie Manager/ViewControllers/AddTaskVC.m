//
//  AddTaskVC.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-18.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "AddTaskVC.h"
#import "DataService.h"

@interface AddTaskVC ()

@end

@implementation AddTaskVC

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
    [self.planLength resignFirstResponder];
    [self.planName resignFirstResponder];
}

- (IBAction)closeBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
    [self.scroller setHidden:true];
    [self.scroller stopAnimating];
}


- (IBAction)addBtnPressed:(id)sender {
    [self resetInputs];
    [self.scroller startAnimating];
    [self.scroller setHidden:false];
    NSString *key = [DataService.sharedInstance.ref childByAutoId].key;
    
    if([self validateInputs]){
        Plan *plan = [[Plan alloc]initWithTitle:self.planName.text progress:[[NSNumber alloc]initWithInt:0] goalDays:(NSNumber *)self.planLength.text uid:key];
            
            [DataService.sharedInstance addPlan:plan completion:^(BOOL *status) {
                if(status){
                    NSDictionary *dict = @{
                        @"title": self.planName.text,
                        @"progress": [[NSNumber alloc]initWithInt:0],
                        @"goalDays": self.planLength.text,
                        @"uid": key
                    };
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlanAdded" object:nil userInfo:dict];
                    [self.scroller setHidden:true];
                    [self.scroller stopAnimating];
                    [self dismissViewControllerAnimated:true completion:nil];
                }else{
                    [self.scroller setHidden:true];
                    [self.scroller stopAnimating];
                }
            }];
    }else{
        [self.scroller setHidden:true];
        [self.scroller stopAnimating];
    }
    
    
}

- (void)resetInputs{
    [self.nameErr setHidden:true];
    [self.daysErr setHidden:true];
    self.nameLine.backgroundColor = [UIColor colorNamed:@"mainColor"];
}

- (BOOL)validateInputs{
    BOOL check = true;
    if([self.planName.text isEqualToString:@""]){
        self.nameErr.text = @"Cannot be empty";
        [self.nameErr setHidden:false];
        self.nameLine.backgroundColor = [UIColor colorNamed:@"errColor"];
        check = false;
    }
    
    if([self.planLength.text isEqualToString:@""]){
        self.daysErr.text = @"Cannot be empty";
        [self.daysErr setHidden:false];
        check = false;
    }
    
    return check;
}

@end
