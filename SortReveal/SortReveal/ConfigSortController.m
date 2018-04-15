//
//  ConfigViewController.m
//  SortReveal
//
//  Created by Eric on 2018/4/12.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "ConfigSortController.h"
#import "Common.h"
#import "UIImage+operations.h"

@interface ConfigSortController ()


@property (strong, nonatomic) IBOutlet UILabel *sortName;
@property (strong, nonatomic) IBOutlet UITextView *inputField;
@property (strong, nonatomic) IBOutlet UIButton *selectOrder;
@property (strong, nonatomic) IBOutlet UIButton *startShow;

@property (strong, nonatomic) IBOutlet UIButton *backButton;



@end

@implementation ConfigSortController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[_inputField layer] setCornerRadius:3];
    [_inputField setContentInset:UIEdgeInsetsMake(0, 10, 0, 0)];
 
    [_backButton setImage:[[UIImage imageNamed:@"backImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [_backButton setTintColor:UIColor.blackColor];
    
    UIImage *img = [[UIImage imageNamed:@"pushImage"] imageWithColor:UIColor.blackColor];
    [_startShow setImage:img forState:UIControlStateNormal];
    [_selectOrder setImage:img forState:UIControlStateNormal];
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [[self view] endEditing:1];
}

- (IBAction)dismiss:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ELSplitVCShouldDismissNotification object:nil];
}

@end
