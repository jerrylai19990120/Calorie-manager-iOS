//
//  PlanCell.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-17.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Plan.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlanCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *numOfDays;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
- (void)configureCellWithPlan:(Plan *)plan;
@end

NS_ASSUME_NONNULL_END
