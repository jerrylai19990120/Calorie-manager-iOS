//
//  HomeVC.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-13.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "HomeVC.h"
#import "MealCell.h"
#import "DataService.h"
#import "User.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCalorieChange:) name:@"CalorieChange" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mealAdded:) name:@"MealAdded" object:nil];
    
    [DataService userWithCompletion:^(User *user) {
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.nameTxt.text = [NSString stringWithFormat:@"Hello, %@!", user.username];
            int number = [user getCaloriedNeededWithAge:[user.age intValue] weight:[user.weight intValue] height:[user.height intValue]];
            self.calorieBudget.text = [NSString stringWithFormat:@"%d", number];
            
            if(user.imgUrl!=nil){
                [DataService.sharedInstance downloadImageWithURL:user.imgUrl imageView:self.userImg];
            }
            
        });
    }];
    
    [DataService.sharedInstance getMealsForTodayWithCompletion:^(NSMutableArray *meals) {
        self.meals = [meals mutableCopy];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            int total = self.calorieBudget.text.intValue;
            for(Meal *meal in self.meals){
                total = total - meal.calories.intValue;
            }
            self.calorieBudget.text = [NSString stringWithFormat:@"%d", total];
            [self.tableView reloadData];
        });
        
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    tap.numberOfTapsRequired = 1;
    [self.userImg setUserInteractionEnabled:true];
    [self.userImg addGestureRecognizer:tap];
}

- (void)handleCalorieChange:(NSNotification *)notif{
    NSDictionary *changes = notif.userInfo;
    int val = [[changes valueForKey:@"changes"]intValue];
    self.calorieBudget.text = [NSString stringWithFormat:@"%d", self.calorieBudget.text.intValue-val];
}

- (void)mealAdded:(NSNotification *)notif{
    NSDictionary *mealInfo = notif.userInfo;
    Meal *meal = [[Meal alloc]initWithName:(NSString *)[mealInfo valueForKey:@"name"] type:(NSString *)[mealInfo valueForKey:@"type"] calories:(NSNumber *)[mealInfo valueForKey:@"calories"] date:(NSString *)[mealInfo valueForKey:@"date"]];
    [self.meals addObject:meal];
    [self.tableView reloadData];
}

- (void)tapAction{
    self.tabBarController.selectedIndex = 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.meals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"MealCell";
    MealCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if(cell == nil){
        return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else{
        
        [cell configureCellWithMeal:[self.meals objectAtIndex:indexPath.row]];
        return cell;
    }
}



@end
