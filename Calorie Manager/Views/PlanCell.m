//
//  PlanCell.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-17.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "PlanCell.h"

@implementation PlanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)configureCellWithPlan:(Plan *)plan{
    self.title.text = plan.title;
    self.img.image = [UIImage imageNamed:@"plan"];
    [self.progressBar setProgress:(plan.progress.floatValue/plan.goalDays.floatValue) animated:true];
    self.numOfDays.text = [NSString stringWithFormat:@"%@ / %@ Days", plan.progress, plan.goalDays];
}


@end
