//
//  ProgressVC.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-13.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedCornerImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProgressVC : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet RoundedCornerImage *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userEmail;
@property (strong, nonatomic) NSMutableArray *plans;
@property (strong, nonatomic) NSMutableArray *inactivePlans;
@property (strong, nonatomic) NSMutableArray *meals;
@end

NS_ASSUME_NONNULL_END
