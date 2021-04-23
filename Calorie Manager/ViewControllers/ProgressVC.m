//
//  ProgressVC.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-13.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "ProgressVC.h"
#import "PlanCell.h"
#import "DataService.h"
#import "MealCell.h"

@interface ProgressVC ()

@end

@implementation ProgressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor colorWithRed:45/255 green:56/255 blue:98/255 alpha:0.6] forKey:NSForegroundColorAttributeName] forState:UIControlStateNormal];
    [self.segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [DataService userWithCompletion:^(User *user) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.username.text = user.username;
            self.userEmail.text = user.email;
            if(user.imgUrl!=nil){
                [DataService.sharedInstance downloadImageWithURL:user.imgUrl imageView:self.userImg];
            }
        });
    }];
    
    [DataService.sharedInstance getAllPlansWithCompletion:^(NSMutableArray *plans) {
        self.plans = [plans mutableCopy];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [DataService.sharedInstance getAllMealsWithCompletion:^(NSMutableArray *meals) {
        self.meals = [meals mutableCopy];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    
    [self.segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)valueChanged:(id)sender{
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            return [self.plans count];
            break;
        case 1:
            return [self.plans count];
            break;
        case 2:
            return [self.meals count];
            break;
        default:
            break;
    }
    return [self.plans count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlanCell" forIndexPath:indexPath];
    
    MealCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"MealCell" forIndexPath:indexPath];
    
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            if(cell==nil){
                return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PlanCell"];
            }else{
                [cell configureCellWithPlan:[self.plans objectAtIndex:indexPath.row]];
                return cell;
            }
            break;
        case 1:
            if(cell==nil){
                return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PlanCell"];
            }else{
                [cell configureCellWithPlan:[self.plans objectAtIndex:indexPath.row]];
                return cell;
            }
            break;
        case 2:
            if(cell2==nil){
                return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MealCell"];
            }else{
                [cell2 configureCellWithMeal:[self.meals objectAtIndex:indexPath.row]];
                return cell2;
            }
            break;
        default:
            break;
    }
    
    return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PlanCell"];
    
}

@end
