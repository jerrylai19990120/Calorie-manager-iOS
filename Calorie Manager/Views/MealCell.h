//
//  MealCell.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-15.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface MealCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *calories;

@end

NS_ASSUME_NONNULL_END
