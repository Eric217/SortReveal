//
//  SortingViewController.m
//  SortReveal
//
//  Created by Eric on 2018/4/11.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "SortingViewController.h"
#import "UIView+frameProperty.h"

@interface SortingViewController ()

@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIBarButtonItem *playButton;


@end

@implementation SortingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self initToolBar];
    [self.view setBackgroundColor:UIColor.whiteColor];


}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_toolBar setFrame:CGRectMake(0, self.view.height-44, self.view.width, 44)];
    
}

- (void)initToolBar {
    
    UIBarButtonItem *forward = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(nextStep:)];
    UIBarButtonItem *backward = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(lastStep:)];
    _playButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(lastStep:)];
    UIBarButtonItem *leftBlank = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
 
    NSArray *itemsArr = [[NSArray alloc] initWithObjects:leftBlank, forward, backward, _playButton, nil];
    
    _toolBar = [[UIToolbar alloc] init];
    [_toolBar setTintColor:UIColor.blackColor];
    [_toolBar setItems:itemsArr];
    [self.view addSubview:_toolBar];
    
}


- (void)nextStep:(id)sender {
    
}
- (void)lastStep:(id)sender {
    
}
- (void)stop:(id)sender {
    
}
- (void)play:(id)sender {
    
}

@end
