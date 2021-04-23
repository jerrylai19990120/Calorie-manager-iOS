//
//  RoundedImage.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-23.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "RoundedImage.h"

@implementation RoundedImage

- (void)awakeFromNib{
    [self setupView];
}

- (void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    [self setupView];
}

- (void)setupView{
    self.layer.cornerRadius = self.layer.bounds.size.width / 2;
    self.layer.masksToBounds = true;
}

@end
