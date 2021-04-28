//
//  HomeVC.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-13.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedCornerImage.h"


NS_ASSUME_NONNULL_BEGIN

@interface HomeVC : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nameTxt;
@property (weak, nonatomic) IBOutlet RoundedCornerImage *userImg;
@property (weak, nonatomic) IBOutlet UILabel *calorieBudget;
@property (strong, nonatomic) NSMutableArray *meals;
@end

NS_ASSUME_NONNULL_END
