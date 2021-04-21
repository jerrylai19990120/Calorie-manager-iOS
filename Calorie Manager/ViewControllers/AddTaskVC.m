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
}

- (IBAction)closeBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


- (IBAction)addBtnPressed:(id)sender {
    
    Plan *plan = [[Plan alloc]initWithTitle:self.planName.text progress:[[NSNumber alloc]initWithInt:0] goalDays:(NSNumber *)self.planLength.text];
    
    [DataService.sharedInstance addPlan:plan completion:^(BOOL *status) {
        if(status){
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
    
}

@end
