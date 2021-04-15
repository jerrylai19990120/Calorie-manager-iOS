//
//  RoundedView.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-15.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "RoundedView.h"

@implementation RoundedView

- (void)awakeFromNib{
    [self setUpView];
}

- (void)setUpView{
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = true;
}

- (void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    [self setUpView];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
