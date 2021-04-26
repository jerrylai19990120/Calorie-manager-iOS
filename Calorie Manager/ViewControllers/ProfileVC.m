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
            if(user.imgUrl!=nil){
                [DataService.sharedInstance downloadImageWithURL:user.imgUrl imageView:self.userImg];
            }
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
    
    self.barView = [[BarChartView alloc]init];
    
    [self.chartView addSubview:self.barView];
    self.barView.backgroundColor = [UIColor whiteColor];
    
    [self.barView.topAnchor constraintEqualToAnchor:self.chartView.topAnchor constant:0].active = true;
    [self.barView.bottomAnchor constraintEqualToAnchor:self.chartView.bottomAnchor constant:0].active = true;
    [self.barView.leadingAnchor constraintEqualToAnchor:self.chartView.leadingAnchor constant:0].active = true;
    [self.barView.trailingAnchor constraintEqualToAnchor:self.chartView.trailingAnchor constant:0].active = true;
    self.barView.translatesAutoresizingMaskIntoConstraints = false;
    
    
    [DataService.sharedInstance getAllMealsWithCompletion:^(NSMutableArray *meals) {
        self.entries = [[NSMutableArray alloc]init];
        dispatch_sync(dispatch_get_main_queue(), ^{
            int i = 0;
            for(Meal *meal in meals){
                [self.entries addObject:[[BarChartDataEntry alloc]initWithX:i y:meal.calories.doubleValue]];
                i++;
                if(i==8){
                    break;
                }
            }
            BarChartDataSet *dataSet = [[BarChartDataSet alloc]initWithEntries:self.entries label:@"Calories For Recent Meals"];
            dataSet.colors = @[[UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor],
            [UIColor blueColor], [UIColor purpleColor], [UIColor systemIndigoColor]];
            self.barView.noDataText = @"Go add some meals";
            self.barView.data = [[BarChartData alloc]initWithDataSet:dataSet];
        });
        
    }];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickPhoto)];
    singleTap.numberOfTapsRequired = 1;
    [self.userImg setUserInteractionEnabled:true];
    [self.userImg addGestureRecognizer:singleTap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mealAdded:) name:@"MealAdded" object:nil];
}

- (void)mealAdded:(NSNotification *)notif{
    NSDictionary *mealInfo = notif.userInfo;
    Meal *meal = [[Meal alloc]initWithName:(NSString *)[mealInfo valueForKey:@"name"] type:(NSString *)[mealInfo valueForKey:@"type"] calories:(NSNumber *)[mealInfo valueForKey:@"calories"] date:(NSString *)[mealInfo valueForKey:@"date"]];
    self.calories.text = [NSString stringWithFormat:@"%@kCal", meal.calories];
    self.mealName.text = meal.mealName;
    self.mealImg.image = [UIImage imageNamed:meal.mealType];
    if([self.entries count]==8){
        [self.entries removeObjectAtIndex:0];
    }
    
    double val = [NSNumber numberWithUnsignedInteger:[self.entries count]].doubleValue;
    
    [self.entries addObject:[[BarChartDataEntry alloc]initWithX:val y:meal.calories.doubleValue]];
    int i = 0;
    for(BarChartDataEntry *entry in self.entries){
        [entry setX:i];
        i++;
    }
    BarChartDataSet *dataSet = [[BarChartDataSet alloc]initWithEntries:self.entries label:@"Calories For Recent Meals"];
    dataSet.colors = @[[UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor],
    [UIColor blueColor], [UIColor purpleColor], [UIColor systemIndigoColor]];
    self.barView.noDataText = @"Go add some meals";
    self.barView.data = [[BarChartData alloc]initWithDataSet:dataSet];
}


- (void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight{
    
}

- (IBAction)logOutBtnPressed:(id)sender {
    [[AuthService sharedInstance]logoutUser];
    [self performSegueWithIdentifier:@"LogOut" sender:self];
}

- (void)pickPhoto{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:true completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.userImg.image = image;
    [DataService.sharedInstance uploadImage:image completion:^(BOOL status) {
        if(status){
            NSLog(@"success");
        }
    }];
    [picker dismissViewControllerAnimated:true completion:nil];
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
