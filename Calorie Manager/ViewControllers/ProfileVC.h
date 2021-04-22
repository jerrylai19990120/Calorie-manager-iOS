//
//  ProfileVC.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-13.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedCornerImage.h"
@import Charts;

NS_ASSUME_NONNULL_BEGIN

@interface ProfileVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *userEmail;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *weight;
@property (weak, nonatomic) IBOutlet UILabel *height;
@property (weak, nonatomic) IBOutlet UIImageView *mealImg;
@property (weak, nonatomic) IBOutlet UILabel *mealName;
@property (weak, nonatomic) IBOutlet UILabel *calories;
@property (weak, nonatomic) IBOutlet UIView *chartView;

@property (strong, nonatomic) NSMutableArray *meals;
- (void)setupBarLineChartView:(BarLineChartViewBase *)barLineChart;
@end

NS_ASSUME_NONNULL_END
