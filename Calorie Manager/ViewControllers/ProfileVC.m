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
@import Charts;

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
    LineChartView *lineView = [[LineChartView alloc]init];
    
    [self.chartView addSubview:lineView];
    lineView.backgroundColor = [UIColor systemBlueColor];
    
    [lineView.topAnchor constraintEqualToAnchor:self.chartView.topAnchor constant:0].active = true;
    [lineView.bottomAnchor constraintEqualToAnchor:self.chartView.bottomAnchor constant:0].active = true;
    [lineView.leadingAnchor constraintEqualToAnchor:self.chartView.leadingAnchor constant:0].active = true;
    [lineView.trailingAnchor constraintEqualToAnchor:self.chartView.trailingAnchor constant:0].active = true;
    lineView.translatesAutoresizingMaskIntoConstraints = false;
    
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

- (void)setupBarLineChartView:(BarLineChartViewBase *)barLineChart{
    
    barLineChart.chartDescription.enabled = false;
    
    barLineChart.drawGridBackgroundEnabled = false;
    
    barLineChart.dragEnabled = true;
    [barLineChart setScaleEnabled:true];
    barLineChart.pinchZoomEnabled = false;
    
    ChartXAxis *xAxis = barLineChart.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    
    barLineChart.rightAxis.enabled = false;
    
}

@end
