//
//  ELSplitViewController.m
//  SortReveal
//
//  Created by Eric on 2018/4/15.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "ELSplitViewController.h"
#import "UIViewController+funcs.h"

@interface ELSplitViewController()

@property (assign) SortType type;

@end



@implementation ELSplitViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _master = [[ConfigSortController alloc] init];
    _detail = [[SortingViewController alloc] init];
  //  [[UINavigationController alloc] initWithRootViewController:_master];
    UINavigationController *detailNavVC = [[UINavigationController alloc] initWithRootViewController:_detail];
    [detailNavVC setToolbarHidden:0];
 
    self.splitVC = [[UISplitViewController alloc] init];
    //[self.splitVC setViewControllers:[NSArray arrayWithObjects:masterNavVC, detailNavVC, nil]];
   // self.splitVC.delegate = _master;
    [self.view addSubview:self.splitVC.view];
    [Config addObserver:self selector:@selector(dismiss) notiName:ELSplitVCShouldDismissNotification];
    [self initOrResetContent:_type];
    [self.splitVC setViewControllers:[NSArray arrayWithObjects:_master.navigationController, nil]];
    self.splitVC.maximumPrimaryColumnWidth = ScreenW;
     
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   // [self.splitVC setViewControllers:[NSArray arrayWithObjects:_master.navigationController, nil]];
    //[_splitVC showViewController:_master.navigationController sender:0];
    //[_splitVC showDetailViewController:_detail.navigationController sender:0];
}
 
- (void)dismiss {
    if (!_backVC) {
        return;
    }
    [self.view.window setRootViewController:_backVC];
}

- (void)initOrResetContent:(SortType)type {
    _type = type;
    //[_master initializeWithSortType:type];
   // [_detail clearContent];
}

- (void)dealloc {
    [Config removeObserver:self];
}


@end
