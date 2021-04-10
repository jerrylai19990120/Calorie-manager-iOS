//
//  RoundedCornerBtn.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-07.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "RoundedCornerBtn.h"

IB_DESIGNABLE
@implementation RoundedCornerBtn

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUpView];
}

- (void)setUpView{
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = true;
}

- (void)prepareForInterfaceBuilder{
    [self prepareForInterfaceBuilder];
    [self setUpView];
}

@end
