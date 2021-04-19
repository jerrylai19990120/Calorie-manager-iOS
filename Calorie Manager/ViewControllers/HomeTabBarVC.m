//
//  HomeTabBarVC.m
//  Calorie Manager
//
//  Created by Jerry Lai on 2021-04-12.
//  Copyright © 2021 Jerry Lai. All rights reserved.
//

#import "HomeTabBarVC.h"
#import "DataService.h"

@interface HomeTabBarVC ()

@end

@implementation HomeTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [DataService.sharedInstance getUserInfo];
}



@end
