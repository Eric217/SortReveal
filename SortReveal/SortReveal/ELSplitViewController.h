//
//  ELSplitViewController.h
//  SortReveal
//
//  Created by Eric on 2018/4/15.
//  Copyright © 2018 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigSortController.h"
#import "SortingViewController.h"
#import "Common.h"

@interface ELSplitViewController : UIViewController

@property (nonatomic, strong) ConfigSortController *master;
@property (nonatomic, strong) SortingViewController *detail;
@property (nonatomic, strong) UISplitViewController *splitVC;
@property (nonatomic, strong) UIViewController *backVC;

- (void)initOrResetContent:(SortType)type;

@end
