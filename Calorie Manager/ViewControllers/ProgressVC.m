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
        });
    }];
    
    [DataService.sharedInstance getAllPlansWithCompletion:^(NSMutableArray *plans) {
        self.plans = [plans mutableCopy];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.plans count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlanCell" forIndexPath:indexPath];
    
    if(cell==nil){
        return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PlanCell"];
    }else{
        [cell configureCellWithPlan:[self.plans objectAtIndex:indexPath.row]];
        return cell;
    }
    
}

@end
