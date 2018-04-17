//
//  SortingViewController.m
//  SortReveal
//
//  Created by Eric on 2018/4/11.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "SortingViewController.h"
#import "UIView+frameProperty.h"
#import "Common.h"
#import "UIViewController+funcs.h"

@interface SortingViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collection;
@property (strong, nonatomic) IBOutlet UIButton *backButton;

@property (nonatomic, copy) NSMutableArray *dataArr;
@property (assign) SortType sortType;
@property (assign) SortOrder sortOrder;

@property (assign) CGFloat edgeDistance;

@end

@implementation SortingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.alwaysBounceVertical = 1;
    _edgeDistance = [Config v_pad:46 plus:15 p:10];
    _collection.contentInset = UIEdgeInsetsMake(15, _edgeDistance, 15, _edgeDistance);
    
    [_backButton setImage:[Config backImage] forState:UIControlStateNormal];
    [self setTitle:@"动态演示"];
    [_backButton addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    [Config addObserver:self selector:@selector(prepareDisplay:) notiName:SortingVCShouldStartDisplayNotification];


}

- (void)clickBack:(id)sender {
    
}

- (void)prepareDisplay:(NSNotification *)noti {
    
    NSUInteger t = ((NSNumber *)(noti.userInfo[kSortType])).unsignedIntegerValue;
    NSUInteger o = ((NSNumber *)(noti.userInfo[kSortOrder])).unsignedIntegerValue;
    
    if (_dataArr) {
        [self presentAlertWithConfirmAction:^(UIAlertAction *alert) {
            [self initialize:noti.userInfo[kDataArr] type:t order:o];
        }];
    } else {
        [self initialize:noti.userInfo[kDataArr] type:t order:o];
    }
}

- (void)initialize:(NSMutableArray *)arr type:(SortType)t order:(SortOrder)o {
    _sortType = t;
    _sortOrder = o;
    _dataArr = arr;
    
    
    
}

- (IBAction)lastStep:(id)sender {
    
}
- (IBAction)nextStep:(id)sender {
    
}

- (void)stop:(id)sender {
    
}
- (IBAction)play:(id)sender {
    
}

- (void)clearContent {
    _dataArr = 0;
    [_collection reloadData];
}

- (void)dealloc {
    [Config removeObserver:self];
}
@end
