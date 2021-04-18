//
//  ProgressVC.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-13.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "ProgressVC.h"
#import "PlanCell.h"

@interface ProgressVC ()

@end

@implementation ProgressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName] forState:UIControlStateNormal];
    [self.segmentedControl setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor colorWithRed:45/255 green:56/255 blue:98/255 alpha:0.6] forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlanCell" forIndexPath:indexPath];
    
    if(cell==nil){
        return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PlanCell"];
    }else{
        [cell configureCell];
        return cell;
    }
    
}

@end
