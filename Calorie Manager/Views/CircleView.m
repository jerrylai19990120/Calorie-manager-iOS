//
//  CircleView.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-16.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (void)awakeFromNib{
    [self setUpView];
}

- (void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    [self setUpView];
}

- (void)setUpView{
    self.layer.cornerRadius = self.layer.bounds.size.width / 2;
    self.layer.masksToBounds = true;
}

@end
