//
//  LogMealVC.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-19.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "LogMealVC.h"
#import "DataService.h"
#import "Meal.h"

@interface LogMealVC ()

@end

@implementation LogMealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor colorWithRed:45/255 green:56/255 blue:98/255 alpha:0.6] forKey:NSForegroundColorAttributeName] forState:UIControlStateNormal];
    [self.segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
}

- (IBAction)closeBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)addBtnPressed:(id)sender {
    
    
    NSInteger index = self.segmentedControl.selectedSegmentIndex;
    NSString *type = @"Unknown";
    if(index==0){
        type = @"Breakfast";
    }else if(index==1){
        type = @"Lunch";
    }else if(index==2){
        type = @"Dinner";
    }else if(index==3){
        type = @"Snack";
    }
    
    Meal *meal = [[Meal alloc]initWithName:self.mealNameTxt.text type:type calories:(NSNumber *)self.caloriesTxt.text];
    [DataService.sharedInstance addMeal:meal completion:^(BOOL *status) {
        if(status){
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
}



@end
