//
//  SortParentController.m
//  SortReveal
//
//  Created by Eric on 2018/4/11.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "SortParentController.h"
#import "Common.h"

#define SplitWidth 400

@interface SortParentController ()

@end

@implementation SortParentController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.whiteColor];
    [self.view setFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    
    _configurator = [[ConfigSortController alloc] init];
    [_configurator.view setFrame:CGRectMake(0, 0, SplitWidth, ScreenH)];

    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:_configurator];
    [self addChildViewController:navVC];
    [self.view addSubview:navVC.view];
    [navVC didMoveToParentViewController:self];
    
    _sortDisplayer = [[SortingViewController alloc] init];
    [self addChildViewController:_sortDisplayer];
    [_sortDisplayer.view setFrame:CGRectMake(SplitWidth, 0, ScreenW - 400, ScreenH)];
    [self.view addSubview:_sortDisplayer.view];
    [_sortDisplayer didMoveToParentViewController:self];
    
    

}


@end
