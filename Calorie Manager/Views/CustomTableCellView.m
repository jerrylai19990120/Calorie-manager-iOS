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
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = true;
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 5;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
