//
//  ELSplitViewController.m
//  SortReveal
//
//  Created by Eric on 2018/4/15.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "ELSplitViewController.h"

@interface ELSplitViewController() <UISplitViewControllerDelegate>

@property (nonatomic, strong) UISplitViewController *splitView;

@end

@implementation ELSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    UINavigationController *masterNavVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:configSortVCId];
    UINavigationController *detailNavVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:sortingVCId];
    
    _master = masterNavVC.viewControllers[0];
    _detail = detailNavVC.viewControllers[0];
    
    _splitView = [[UISplitViewController alloc] init];
    [_splitView setViewControllers:[NSArray arrayWithObjects:masterNavVC, detailNavVC, nil]];
    _splitView.delegate = self;
    
    [self.view addSubview:_splitView.view];

    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(dismiss) name:ELSplitVCShouldDismissNotification object:nil];
    
}

- (void)dismiss {
    
    if (!_backVC) {
        return;
    }
    [self.view.window setRootViewController:_backVC];
}

- (void)initOrResetSplitVC:(SortType)type {
    
}



@end
