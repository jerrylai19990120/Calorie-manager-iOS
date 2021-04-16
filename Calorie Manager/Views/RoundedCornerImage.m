//
//  RoundedCornerImage.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-16.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "RoundedCornerImage.h"

@implementation RoundedCornerImage

- (void)awakeFromNib{
    [self setUpView];
}

- (void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    [self setUpView];
}

- (void)setUpView{
    self.layer.cornerRadius = 30;
    self.layer.masksToBounds = true;
}
@end
