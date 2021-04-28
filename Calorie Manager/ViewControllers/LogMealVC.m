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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeyboard{
    [self.caloriesTxt resignFirstResponder];
    [self.mealNameTxt resignFirstResponder];
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
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    NSString *today = [formatter stringFromDate:[NSDate date]];
    
    Meal *meal = [[Meal alloc]initWithName:self.mealNameTxt.text type:type calories:(NSNumber *)self.caloriesTxt.text date:today];
    [DataService.sharedInstance addMeal:meal completion:^(BOOL *status) {
        if(status){
            NSDictionary *mealInfo = @{
                @"name": self.mealNameTxt.text,
                @"type": type,
                @"calories": self.caloriesTxt.text,
                @"date": today
            };
            
            NSDictionary *changes = @{
                @"changes": self.caloriesTxt.text
            };
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MealAdded" object:self userInfo:mealInfo];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CalorieChange" object:self userInfo:changes];
            
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
}



@end
