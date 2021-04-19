//
//  HomeVC.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-13.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTabBarVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeVC : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nameTxt;


@end

NS_ASSUME_NONNULL_END
