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
    [self.scroller setHidden:true];
    [self.scroller stopAnimating];
    [self resetInputs];
}

- (void)dismissKeyboard{
    [self.caloriesTxt resignFirstResponder];
    [self.mealNameTxt resignFirstResponder];
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
    
    if([self validateInputs]){
        
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
    [self.calErr setHidden:true];
    self.nameLine.backgroundColor = [UIColor colorNamed:@"mainColor"];
}

- (BOOL)validateInputs{
    BOOL check = true;
    
    if([self.mealNameTxt.text isEqualToString:@""]){
        self.nameLine.backgroundColor = [UIColor colorNamed:@"errColor"];
        self.nameErr.text = @"Cannot be empty";
        [self.nameErr setHidden:false];
        check = false;
    }
    
    if([self.caloriesTxt.text isEqualToString:@""]){
        self.calErr.text = @"Cannot be empty";
        [self.calErr setHidden:false];
        check = false;
    }
    
    return check;
}

@end
