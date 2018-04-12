//
//  SortParentController.h
//  SortReveal
//
//  Created by Eric on 2018/4/11.
//  Copyright © 2018 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigSortController.h"
#import "SortingViewController.h"

@interface SortParentController : UIViewController

@property (nonatomic, strong) ConfigSortController *configurator;
@property (nonatomic, strong) SortingViewController *sortDisplayer;


@end
