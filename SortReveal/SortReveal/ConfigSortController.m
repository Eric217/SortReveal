//
//  ConfigViewController.m
//  SortReveal
//
//  Created by Eric on 2018/4/12.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "ConfigSortController.h"
#import "UIImage+operations.h"
#import "UIViewController+funcs.h"
#import "SelectOrderController.h"
#import "Protocols.h"

@interface ConfigSortController () <UITextViewDelegate, SimpleTransfer>

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
    [_inputField setContentInset:UIEdgeInsetsMake(0, 8, 0, 6)];
 
    [_backButton setImage:[[UIImage imageNamed:@"backImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [_backButton setTintColor:UIColor.blackColor];
    
    UIImage *img = [[UIImage imageNamed:@"pushImage"] imageWithColor:UIColor.blackColor];
    [_startShow setImage:img forState:UIControlStateNormal];
    [_selectOrder setImage:img forState:UIControlStateNormal];
    _inputField.delegate = self;
    [_selectOrder addTarget:self action:@selector(selectOrder:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)selectOrder:(id)sender {
    
    SelectOrderController *selectVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:selectOrderVCId];
    selectVC.delegate = self;
    [self.navigationController pushViewController:selectVC animated:1];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text characterAtIndex:0] == '\n') {
        [textView endEditing:1];
        return 0;
    }
    return 1;
}

- (void)initializeContent:(SortType)type {
    NSArray *names = [Config getArrayDataFromFile:SortNameFile];
    [_sortName setText:names[type]];
    [_inputField setText:@""];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [[self view] endEditing:1];
}

- (IBAction)dismiss:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ELSplitVCShouldDismissNotification object:nil];
}

///NSArray, 0: NSStringFromCGPoint(sec, row) 1: name
- (void)transferData:(id)data {
    NSArray *a = data;
    CGPoint indexPath = CGPointFromString(a[0]);
    int section = indexPath.x;
    int row = indexPath.y;
    NSLog(@"%d, %d", section, row);
    [_selectOrder setTitle:a[1] forState:UIControlStateNormal];
}


@end
