//
//  ELSplitViewController.m
//  SortReveal
//
//  Created by Eric on 2018/4/15.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "ELSplitViewController.h"
#import "UIViewController+funcs.h"

@interface ELSplitViewController() <UISplitViewControllerDelegate>

@property (nonatomic, strong) UISplitViewController *splitView;
@property (assign) SortType type;

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

    [Config addObserver:self selector:@selector(dismiss) notiName:ELSplitVCShouldDismissNotification];
    [self initOrResetContent:_type];
    
}

- (void)dismiss {
    
    if (!_backVC) {
        return;
    }
    [self.view.window setRootViewController:_backVC];
}

- (void)initOrResetContent:(SortType)type {
    _type = type;
    [_master initializeWithSortType:type];
    [_detail clearContent];
}

- (void)dealloc {
    [Config removeObserver:self];
}


@end
