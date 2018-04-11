//
//  ConfigSortController.m
//  SortReveal
//
//  Created by Eric on 2018/4/11.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "ConfigSortController.h"
#import "SortingViewController.h"

@interface ConfigSortController ()
@property (nonatomic, strong) SortingViewController *sortingVC;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *dataInputView;
@property (nonatomic, strong) 

@end

@implementation ConfigSortController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    [self addChildViewController:_sortingVC];
    
    
    
    
}

@end
