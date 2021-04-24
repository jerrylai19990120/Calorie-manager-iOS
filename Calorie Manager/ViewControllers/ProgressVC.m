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
        self.inactivePlans = [[NSMutableArray alloc]init];
        self.plans = [[NSMutableArray alloc]init];
        
        for(Plan *item in plans){
            
            if(item.goalDays.intValue == item.progress.intValue){
                [self.inactivePlans addObject:item];
            }else{
                [self.plans addObject:item];
            }
        }
        
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
            return [self.inactivePlans count];
            break;
        case 2:
            return [self.meals count];
            break;
        default:
            break;
    }
    return [self.plans count];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /*PlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlanCell" forIndexPath:indexPath];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnCellAction)];
    tap.numberOfTapsRequired = 1;
    [cell setUserInteractionEnabled:true];
    [cell addGestureRecognizer:tap];*/
    
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            [self tapOnCellActionWithPlan:[self.plans objectAtIndex:indexPath.row]];
            break;
        default:
            break;
    }
}

- (void)tapOnCellActionWithPlan:(Plan *)plan{
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Actions" message:@"Add progress to your plan" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Log Progress" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [DataService.sharedInstance logPlanProgressWithPlan:plan];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Remove Plan" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [DataService.sharedInstance removePlan:plan];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:true completion:nil];
    }]];
    
    [self presentViewController:actionSheet animated:true completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlanCell" forIndexPath:indexPath];
    
    MealCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"MealCell" forIndexPath:indexPath];
    
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            if(cell==nil || [self.plans count]==0){
                return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PlanCell"];
            }else{
                [cell configureCellWithPlan:[self.plans objectAtIndex:indexPath.row]];
                return cell;
            }
            break;
        case 1:
            if(cell==nil || [self.inactivePlans count]==0){
                return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PlanCell"];
            }else{
                [cell configureCellWithPlan:[self.inactivePlans objectAtIndex:indexPath.row]];
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
