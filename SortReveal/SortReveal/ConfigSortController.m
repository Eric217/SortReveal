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

@property (strong, nonatomic) UILabel *sortName;
@property (strong, nonatomic) UITextView *inputField;
@property (strong, nonatomic) UIButton *selectOrder;
@property (strong, nonatomic) UIButton *startShow;

@property (assign) SortOrder sortOrder;
@property (assign) SortType sortType;

@end

@implementation ConfigSortController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //navigation item
    UIBarButtonItem *backItem = [Config customBackBarButtonItemWithTitle:@"返回" target:self action:@selector(dismiss:)];
    self.navigationItem.leftBarButtonItems = @[backItem];
    self.navigationItem.title = @"配置排序";
    
    //sort name and two description labels
    _sortName = [self getLabelWithTitle:0 fontSize:(IPAD ? 29 : 27)];
    [self.view addSubview:_sortName];
    
    UILabel *label1 = [self getLabelWithTitle:@"输入要演示的排序内容。" fontSize:18];
    [self.view addSubview:label1];
    UILabel *label2 = [self getLabelWithTitle:@"以空格分隔每个元素。" fontSize:18];
    [self.view addSubview:label2];

    //start show
    UIImage *img = [Config pushImage];
    _startShow = [[UIButton alloc] init];
    [_startShow.titleLabel setFont:[UIFont systemFontOfSize:23]];
    [_startShow setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [_startShow setTitle:@"开始演示" forState:UIControlStateNormal];
    [_startShow setImage:img forState:UIControlStateNormal];
    [_startShow setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [_startShow setImageEdgeInsets:UIEdgeInsetsMake(0, 125, 0, 0)];
    [_startShow addTarget:self action:@selector(startDisplay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startShow];
    
    //sort order
    UIView *way = [[UIView alloc] init];
    [way setBackgroundColor:UIColor.clearColor];
    [self.view addSubview:way];
    UILabel *wayDec = [self getLabelWithTitle:@"排序方式" fontSize:20];
    [way addSubview:wayDec];
    _selectOrder = [[UIButton alloc] init];
    [_selectOrder setTitle:@"自动推断" forState:UIControlStateNormal];
    [_selectOrder.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [_selectOrder setTitleColor:systemBlue forState:UIControlStateNormal];
    [_selectOrder addTarget:self action:@selector(selectOrder:) forControlEvents:UIControlEventTouchUpInside];
    [_selectOrder setImage:img forState:UIControlStateNormal];
    [_selectOrder setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [_selectOrder setImageEdgeInsets:UIEdgeInsetsMake(0, 100, 0, 0)];
    [way addSubview:_selectOrder];
    
    //input field
    _inputField = [[UITextView alloc] init];
    [_inputField setFont:[UIFont systemFontOfSize:22]];
    [[_inputField layer] setCornerRadius:4];
    _inputField.clipsToBounds = 1;
    [_inputField setContentInset:UIEdgeInsetsMake(0, 8, 0, 8.5)];
    _inputField.delegate = self;
    [self.view addSubview:_inputField];
    
    [Config addObserver:self selector:@selector(resignResponder) notiName:ELTextFieldShouldResignNotification];
    _sortOrder = SortOrderAutomatic;
    self.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
 
    //layout
    [_sortName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(36);
        make.top.equalTo(self.view).offset(64+[Config v_pad:44 plus:28 p:26 min:24]);
    }];
    [_startShow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).inset([Config v_pad:58 plus:34 p:30 min:24]);
        make.height.mas_greaterThanOrEqualTo(44);
        make.centerX.equalTo(self.view);
    }];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(24);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.sortName.mas_bottom).offset([Config v_pad:45 plus:36 p:32 min:25]);
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(21);
        make.left.right.equalTo(self.view);
        make.top.equalTo(label1.mas_bottom).offset(3);
    }];
    [way mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.startShow.mas_top).inset([Config v_pad:65 plus:40 p:36 min:32]);
        make.size.mas_equalTo(CGSizeMake(240, 61));
    }];
    [wayDec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(way).inset(110);
        make.left.greaterThanOrEqualTo(way);
        make.centerY.equalTo(way);
        make.width.mas_greaterThanOrEqualTo(116);
    }];
    [_selectOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(way);
        make.right.equalTo(way).inset(14);
        make.width.mas_greaterThanOrEqualTo(114);
        make.left.mas_greaterThanOrEqualTo(way);
    }];
    [_inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).inset(40);
        make.top.equalTo(label2.mas_bottom).offset(IPAD ? 29 : 24);
        make.bottom.equalTo(way.mas_top).inset(IPAD ? 29 : 25);
    }];
    
}

- (UILabel *)getLabelWithTitle:(nullable NSString *)title fontSize:(CGFloat)fontSize {
    UILabel *l = [[UILabel alloc] init];
    [l setText:title];
    [l setFont:[UIFont systemFontOfSize:fontSize]];
    [l setTextAlignment:NSTextAlignmentCenter];
    //l.numberOfLines = 0;
    return l;
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
        //TODO: - 一系列判断 是否输入内容与选择排序方式可行，不可行的话提示。
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


- (void)dismiss:(id)sender {
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
