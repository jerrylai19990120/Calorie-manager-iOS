//
//  ProfileVC.h
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-13.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedCornerImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileVC : UIViewController
@property (weak, nonatomic) IBOutlet RoundedCornerImage *userImg;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *userEmail;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *weight;
@property (weak, nonatomic) IBOutlet UILabel *height;


@end

NS_ASSUME_NONNULL_END
