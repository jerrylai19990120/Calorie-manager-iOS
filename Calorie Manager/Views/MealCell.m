//
//  MealCell.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-15.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "MealCell.h"


@interface MealCell()

@end


@implementation MealCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)configureCellWithMeal:(Meal *)meal{
    self.img.image = [UIImage imageNamed:meal.mealType];
    self.calories.text = [NSString stringWithFormat:@"%@kCal", meal.calories];
    self.name.text = meal.mealName;
}

@end
