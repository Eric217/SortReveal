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
///这里采用strong加改变内容形式切换root vc. 如果weak则被自动回收了，即使我有一个指针指向它。
@property (nonatomic, strong) UIViewController *backVC;

- (void)initOrResetSplitVC:(SortType)type;

@end
