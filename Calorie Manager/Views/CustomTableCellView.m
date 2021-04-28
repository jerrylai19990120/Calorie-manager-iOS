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
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
