//
//  ProfileVC.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-13.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "ProfileVC.h"
#import "AuthService.h"
#import "DataService.h"
#import "Meal.h"

@interface ProfileVC ()

@end

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [DataService userWithCompletion:^(User *user) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.username.text = user.username;
            self.age.text = (NSString *)user.age;
            self.height.text = (NSString *)user.height;
            self.weight.text = (NSString *)user.weight;
            self.userEmail.text = user.email;
        });
        
    }];
    
    [DataService.sharedInstance getAllMealsWithCompletion:^(NSMutableArray *meals) {
        self.meals = [meals mutableCopy];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            if([self.meals count]==0){
                self.calories.text = @"0kCal";
                self.mealName.text = @"No meals logged yet";
                self.mealImg.image = [UIImage imageNamed:@"Breakfast"];
            }else{
                Meal* meal = [self.meals objectAtIndex:([self.meals count]-1)];
                self.calories.text = [NSString stringWithFormat:@"%@kCal", meal.calories];
                self.mealName.text = meal.mealName;
                self.mealImg.image = [UIImage imageNamed:meal.mealType];
            }
            
        });
    }];
    
}

- (IBAction)logOutBtnPressed:(id)sender {
    [[AuthService sharedInstance]logoutUser];
    [self performSegueWithIdentifier:@"LogOut" sender:self];
}

- (IBAction)pictureBtnPressed:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = false;
    imagePicker.mediaTypes = @[@"public.image", @"public.movie"];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
}

@end
