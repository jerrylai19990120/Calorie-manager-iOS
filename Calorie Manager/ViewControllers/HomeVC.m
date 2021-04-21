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

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [DataService userWithCompletion:^(User *user) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.nameTxt.text = [NSString stringWithFormat:@"Hello, %@!", user.username];
            int number = 66+6.23*[user.weight intValue]+12.7*[user.height intValue]-4.7*[user.age intValue];
            self.calorieBudget.text = [NSString stringWithFormat:@"%d", number];
            
        });
    }];
    
    
    [DataService.sharedInstance getAllMealsWithCompletion:^(NSMutableArray *meals) {
        self.meals = [[NSMutableArray alloc]initWithArray:meals];
    }];
    

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
        [cell configureCellWithMeal:[self.meals objectAtIndex:(NSUInteger)indexPath]];
        return cell;
    }
}



@end
