//
//  ConfigViewController.m
//  SortReveal
//
//  Created by Eric on 2018/4/12.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "ConfigSortController.h"
#import "SelectOrderController.h"
#import "Protocols.h"
#import <Masonry/Masonry.h>

@interface ConfigSortController () <UITextViewDelegate, SimpleTransfer>

@property (strong, nonatomic) IBOutlet UILabel *sortName;
@property (strong, nonatomic) IBOutlet UITextView *inputField;
@property (strong, nonatomic) IBOutlet UIButton *selectOrder;
@property (strong, nonatomic) IBOutlet UIButton *startShow;

@property (assign) SortOrder sortOrder;
@property (assign) SortType sortType;

@end

@implementation ConfigSortController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[_inputField layer] setCornerRadius:3];
    [_inputField setContentInset:UIEdgeInsetsMake(0, 8, 0, 6)];
 
    UIBarButtonItem *backItem = [Config customBackBarButtonItemWithTitle:@"返回" target:self action:@selector(dismiss:)];
    self.navigationItem.leftBarButtonItems = @[backItem];
    self.navigationItem.title = @"配置排序";
    //[_backButton setImage:[Config backImage] forState:UIControlStateNormal];
    
    UIImage *img = [Config pushImage];
    [_startShow setImage:img forState:UIControlStateNormal];
    [_selectOrder setImage:img forState:UIControlStateNormal];
    _inputField.delegate = self;
    [_selectOrder addTarget:self action:@selector(selectOrder:) forControlEvents:UIControlEventTouchUpInside];
    [Config addObserver:self selector:@selector(resignResponder) notiName:ELTextFieldShouldResignNotification];
    [_startShow addTarget:self action:@selector(startDisplay:) forControlEvents:UIControlEventTouchUpInside];
    _sortOrder = SortOrderAutomatic;
    [_selectOrder setTitle:@"自动推断" forState:UIControlStateNormal];
 
}

- (void)resignResponder {
    [_inputField resignFirstResponder];
    
}

- (void)startDisplay:(id)sender {
 
    NSMutableArray *inputData = [[_inputField.text componentsSeparatedByString:@" "] mutableCopy];
    if ([inputData containsObject:@""]) {
        [inputData removeObject:@""];
    }
    if (SortTypeHeap == _sortType) {
        //TODO: - 一系列判断 是否输入内容与选择排序方式可行，不可行提示。
    }

    NSDictionary *userinfo = [NSDictionary dictionaryWithObjects:@[inputData, [NSNumber numberWithUnsignedInteger:_sortType], [NSNumber numberWithUnsignedInteger:_sortOrder]] forKeys:@[kDataArr, kSortType, kSortOrder]];
    [Config postNotification:SortingVCShouldStartDisplayNotification message:userinfo];
}

- (void)selectOrder:(id)sender {
    
    SelectOrderController *selectVC = [[SelectOrderController alloc] init];
    selectVC.delegate = self;
    [self.navigationController pushViewController:selectVC animated:1];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (![text isEqual: @""] && [text characterAtIndex:0] == '\n') {
        [textView endEditing:1];
        return 0;
    }
    return 1;
}

- (void)initializeWithSortType:(SortType)type {
    NSArray *names = [Config getArrayDataFromFile:SortNameFile];
    [_sortName setText:names[type]];
    [_inputField setText:@""];
    _sortType = type;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [[self view] endEditing:1];
}


- (IBAction)dismiss:(id)sender {
    [Config postNotification:ELSplitVCShouldDismissNotification message:nil];
}

///NSArray, 0: order number 1: name
- (void)transferData:(id)data {
    NSArray *a = data;
    _sortOrder = ((NSNumber *)a[0]).longValue;
    [_selectOrder setTitle:a[1] forState:UIControlStateNormal];
}

- (void)dealloc
{
    [Config removeObserver:self];
}

@end
