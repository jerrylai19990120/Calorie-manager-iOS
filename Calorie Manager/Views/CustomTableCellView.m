//
//  CustomTableCellView.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-27.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "CustomTableCellView.h"

@implementation CustomTableCellView

- (void)awakeFromNib{
    [self setupView];
}

- (void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    [self setupView];
}

- (void)setupView{
    self.layer.shadowRadius = 6;
    self.layer.shadowOpacity = 0.36;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.cornerRadius = 10;
}


@end
