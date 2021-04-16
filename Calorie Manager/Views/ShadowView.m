//
//  ShadowView.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-16.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "ShadowView.h"

@implementation ShadowView

- (void)awakeFromNib{
    [self setUpView];
}

- (void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    [self setUpView];
}

- (void)setUpView{
    
    self.layer.shadowRadius = 6;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = true;
}

@end
