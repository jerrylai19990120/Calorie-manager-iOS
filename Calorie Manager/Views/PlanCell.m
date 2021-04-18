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

- (void)configureCell{
    self.img.image = [UIImage imageNamed:@"plan"];
    self.progressBar.progress = 0.6;
    self.numOfDays.text = @"6 / 10 Days";
}

@end
