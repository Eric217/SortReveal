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
#import "UIViewController+funcs.h"
#import <Masonry/Masonry.h>

@interface ConfigSortController () <UITextViewDelegate, SimpleTransfer>

@property (strong, nonatomic) UILabel *sortNameLabel;
@property (strong, nonatomic) UITextView *inputField;
@property (strong, nonatomic) UIButton *selectOrder;
@property (strong, nonatomic) UIButton *startShow;
@property (strong, nonatomic) UILabel *label1;
@property (strong, nonatomic) UIView *way;

@property (nonatomic, copy) NSString *sortName;
@property (strong, nonatomic) UIViewController *anotherRootVC;
@property (strong, nonatomic) SortingViewController *sortingVC;

@property (assign) SortOrder sortOrder;
@property (assign) SortType sortType;

@end

@implementation ConfigSortController

//TODO: - dynamic update views
//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//
//    if (ScreenH - self.view.bounds.size.height > 100 && ![self isDevicePortait]) {
//        [self update4Y:76 label:12 way:3 start:7 tfup:6 tfBott:2];
//    } else {
//        [self update4Y:64+[Config v_pad:44 plus:28 p:26 min:24] label:[Config v_pad:45 plus:36 p:32 min:25] way:[Config v_pad:65 plus:40 p:36 min:32] start:[Config v_pad:58 plus:34 p:30 min:24] tfup:(IPAD ? 29 : 24) tfBott:IPAD ? 29 : 25];
//    }
//
//}

//- (void)update4Y:(CGFloat)y1 label:(CGFloat)y2 way:(CGFloat)y3 start:(CGFloat)y4 tfup:(CGFloat)tfup tfBott:(CGFloat)tfBott {
//    [_sortNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(y1);
//    }];
//
//    [_label1 mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.sortNameLabel.mas_bottom).offset(y2);
//    }];
//
//    [_way mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.startShow.mas_top).inset(y3);
//    }];
//
//    [_startShow mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view).inset(y4);
//    }];
//    [_inputField mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.label1.mas_bottom).offset(24 + tfup);
//        make.bottom.equalTo(self.way.mas_top).inset(tfBott);
//    }];
//}





//MARK: - 第二步
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //navigation item
    UIBarButtonItem *backItem = [Config customBackBarButtonItemWithTitle:@"返回" target:self action:@selector(dismiss:)];
    self.navigationItem.leftBarButtonItems = @[backItem];
    self.navigationItem.title = @"配置排序";
    
    //sort name and two description labels
    _sortNameLabel = [self getLabelWithTitle:0 fontSize:(IPAD ? 29 : 27)];
    [self.view addSubview:_sortNameLabel];
    [_sortNameLabel setText:_sortName];
    
    _label1 = [self getLabelWithTitle:@"输入要演示的排序内容。" fontSize:18];
    [self.view addSubview:_label1];
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
    _way = [[UIView alloc] init];
    [_way setBackgroundColor:UIColor.clearColor];
    [self.view addSubview:_way];
    UILabel *wayDec = [self getLabelWithTitle:@"排序方式" fontSize:20];
    [_way addSubview:wayDec];
    _selectOrder = [[UIButton alloc] init];
    [_selectOrder setTitle:@"自动推断" forState:UIControlStateNormal];
    [_selectOrder.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [_selectOrder setTitleColor:systemBlue forState:UIControlStateNormal];
    [_selectOrder addTarget:self action:@selector(selectOrder:) forControlEvents:UIControlEventTouchUpInside];
    [_selectOrder setImage:img forState:UIControlStateNormal];
    [_selectOrder setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [_selectOrder setImageEdgeInsets:UIEdgeInsetsMake(0, 100, 0, 0)];
    [_way addSubview:_selectOrder];
    
    //input field
    _inputField = [[UITextView alloc] init];
    [_inputField setFont:[UIFont systemFontOfSize:22]];
    [[_inputField layer] setCornerRadius:4];
    _inputField.clipsToBounds = 1;
    _inputField.returnKeyType = UIReturnKeyDone;
    [_inputField setContentInset:UIEdgeInsetsMake(0, 8, 0, 8.5)];
    _inputField.delegate = self;
    [self.view addSubview:_inputField];
    
    [Config addObserver:self selector:@selector(resignResponder) notiName:ELTextFieldShouldResignNotification];
    _sortOrder = SortOrderAutomatic;
    self.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
 
    //layout
    [_sortNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(36);
        make.top.equalTo(self.view).offset(64+[Config v_pad:44 plus:28 p:26 min:24]);
    }];
    [_startShow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).inset([Config v_pad:58 plus:34 p:30 min:24]);
        make.height.mas_equalTo(44);
        make.centerX.equalTo(self.view);
    }];
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(24);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.sortNameLabel.mas_bottom).offset([Config v_pad:45 plus:36 p:32 min:25]);;
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(21);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.label1.mas_bottom).offset(3);
    }];
    [_way mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.startShow.mas_top).inset([Config v_pad:65 plus:40 p:36 min:32]);
        make.size.mas_equalTo(CGSizeMake(240, 61));
    }];
    [wayDec mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.way);
        make.centerY.equalTo(self.way);
        make.size.mas_equalTo(CGSizeMake(126, 55));
    }];
    [_selectOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.way);
        make.right.equalTo(self.way).inset(14);
        make.size.mas_equalTo(CGSizeMake(114, 55));
        
    }];
    [_inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).inset(40);
        make.top.equalTo(self.label1.mas_bottom).offset(24 + (IPAD ? 29 : 24));
        make.bottom.equalTo(self.way.mas_top).inset(IPAD ? 29 : 25);
    }];
 
}

- (UILabel *)getLabelWithTitle:(nullable NSString *)title fontSize:(CGFloat)fontSize {
    UILabel *l = [[UILabel alloc] init];
    [l setText:title];
    [l setFont:[UIFont systemFontOfSize:fontSize]];
    [l setTextAlignment:NSTextAlignmentCenter];
    return l;
}

- (void)resignResponder {
    [_inputField resignFirstResponder];
}

- (NSMutableArray *)inputArr {
    NSMutableArray *inputData = [[_inputField.text componentsSeparatedByString:@" "] mutableCopy];
    if ([inputData containsObject:@""]) {
        [inputData removeObject:@""];
    }
    return inputData;
}

- (void)showDetailNavVCWithRoot:(UIViewController *)vc {
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:vc];
    [n setToolbarHidden:0];
    [self.splitViewController showDetailViewController:n sender:0];
    [_inputField resignFirstResponder];
}

- (void)startDisplay:(id)sender {
 
    if (!_sortingVC) { //直接正常display开始
        
        NSMutableArray *inputData = [self inputArr];
        if (!inputData.count) {
            return;
        }
        //if (SortTypeHeap == _sortType) {
        //TODO: - 一系列判断 是否输入内容与选择排序方式可行，不可行的话提示。
        //}
        _sortingVC = [[SortingViewController alloc] initWithArr:inputData sortType:_sortType sortOrder:_sortOrder];
        [self showDetailNavVCWithRoot:_sortingVC];
    } else {
        [_sortingVC stopTimer:0];
        NSString *msg = @"有演示中的排序。要开始新的排序吗";
        [self presentAlertWithConfirmTitle:@"提醒" message:msg Action:^(UIAlertAction *_) {
            NSMutableArray *inputData = [self inputArr];
            if (!inputData.count) {
                [self showDetailNavVCWithRoot:[[SortingViewController alloc] init]];
                self.sortingVC = 0;
            } else {
                self.sortingVC = [[SortingViewController alloc] initWithArr:inputData sortType:self.sortType sortOrder:self.sortOrder];
                [self showDetailNavVCWithRoot:self.sortingVC];
            }
        }];
       
    }
 
}

- (void)selectOrder:(id)sender {
    [_inputField endEditing:1];
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


//MARK: - 第一步初始化基本数据
- (instancetype)initWithSortType:(SortType)type anotherRoot:(UIViewController *)rootvc {
    self = [super init];
    if (self) {
        _sortType = type;
        NSArray *names = [Config getArrayDataFromFile:SortNameFile];
        _sortName = names[type];
        _anotherRootVC = rootvc;
    }
    return self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [[self view] endEditing:1];
}


- (void)dismiss:(id)sender {
    [self.view.window setRootViewController:_anotherRootVC];
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
