//
//  ConfigSortController.m
//  SortReveal
//
//  Created by Eric on 2018/4/11.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "ConfigSortController.h"
#import "SortingViewController.h"
#import "UIView+frameProperty.h"

@interface ConfigSortController ()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *dataInputView;

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation ConfigSortController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.whiteColor];
    [self setTitle:@"设置排序内容"];
    self.title = @"dasdqa";
    
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 70, 40)];
    [_backButton setTitle:@"返回" forState:UIControlStateNormal];
    [_backButton setImage:[UIImage imageNamed:@"backImage"] forState:UIControlStateNormal];
    [self.view addSubview:_backButton];
    
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
   
    [_backButton setY:self.parentViewController.navigationController.navigationBar.maxY - 55];
    
}

@end
