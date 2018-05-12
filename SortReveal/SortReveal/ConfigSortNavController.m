//
//  ConfigSortNavController.m
//  SortReveal
//
//  Created by Eric on 2018/4/30.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "ConfigSortNavController.h"

@interface ConfigSortNavController ()

@end

@implementation ConfigSortNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTintColor:UIColor.blackColor];
}

- (void)collapseSecondaryViewController:(UIViewController *)secondaryViewController forSplitViewController:(UISplitViewController *)splitViewController {
    [self pushViewController:secondaryViewController animated:1];
}


- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    
    return 0;
}
 

@end
