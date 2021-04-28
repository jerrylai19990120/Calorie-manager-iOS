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
}

- (void)dismissKeyboard{
    [self.planLength resignFirstResponder];
    [self.planName resignFirstResponder];
}

- (IBAction)closeBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


- (IBAction)addBtnPressed:(id)sender {
    
    NSString *key = [DataService.sharedInstance.ref childByAutoId].key;
    
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
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
    
}

@end
