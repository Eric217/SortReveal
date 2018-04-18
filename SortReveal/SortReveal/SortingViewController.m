//
//  SortingViewController.m
//  SortReveal
//
//  Created by Eric on 2018/4/11.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "SortingViewController.h"
#import "UIView+funcs.h"
#import "ELCollectionCell.h"
#import "UIView+frameProperty.h"
#import "UIViewController+funcs.h"
#import "Sorters.h"

@interface SortingViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collection;
@property (strong, nonatomic) IBOutlet UIButton *backButton;

@property (nonatomic, copy) NSArray *originDataArr;
@property (nonatomic, copy) NSMutableArray<NSArray *> *viewDataArr;

@property (nonatomic, strong) id <Sorter> sorter;
@property (assign) SortType sortType;
@property (assign) SortOrder sortOrder;

@property (assign) CGFloat edgeDistance;
@property (assign) CGSize itemSize;

@end

@implementation SortingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_collection setAllowsSelection:0];
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.alwaysBounceVertical = 1;
   
    _edgeDistance = [Config v_pad:30 plus:15 p:10 min:10];
    _collection.contentInset = UIEdgeInsetsMake(30, _edgeDistance, 15, _edgeDistance);
    [_collection registerClass:ELTreeUnitCell.class forCellWithReuseIdentifier:NSStringFromClass(ELTreeUnitCell.class)];
    [_collection registerClass:ELLinearUnitCell.class forCellWithReuseIdentifier:NSStringFromClass(ELLinearUnitCell.class)];
    
    [_backButton setImage:[Config backImage] forState:UIControlStateNormal];
    [self setTitle:@"动态演示"];
    [_backButton addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    [Config addObserver:self selector:@selector(prepareDisplay:) notiName:SortingVCShouldStartDisplayNotification];

}

///点击展示界面上的返回按钮
- (void)clickBack:(id)sender {
    
    
}

///点击展示按钮后，如果正在展示则询问，否则直接展示原始数据第一单元。prepare后调用initialize来开始。
- (void)prepareDisplay:(NSNotification *)noti {
    
    NSUInteger t = ((NSNumber *)(noti.userInfo[kSortType])).unsignedIntegerValue;
    NSUInteger o = ((NSNumber *)(noti.userInfo[kSortOrder])).unsignedIntegerValue;
    
    if (_originDataArr) {
        [self presentAlertWithConfirmTitle:@"提醒" message:@"有演示中的排序。要开始新的排序吗" Action:^(UIAlertAction *alert) {
            self.viewDataArr = [[NSMutableArray alloc] init];
            [self initializeWithArr:noti.userInfo[kDataArr] type:t order:o];
        }];
    } else {
        [self initializeWithArr:noti.userInfo[kDataArr] type:t order:o];
    }
}

///由prepare调用，展示开始的唯一入口，参数来更新原始数据、排序种类、顺序方式
- (void)initializeWithArr:(NSArray *)arr type:(SortType)t order:(SortOrder)o {
    _sortType = t;
    _sortOrder = o;
    _originDataArr = arr;
    [self initializeSorter];
    [self updateItemSize];
    [_viewDataArr addObject:self.originDataArr]; //copy点语法
    [_collection reloadData];
    
    //TODO: - 这个为什么崩？
    //NSIndexPath *idx = [NSIndexPath indexPathForItem:0 inSection:0];
    //[_collection insertItemsAtIndexPaths:@[idx]];
   
}

///由initializeWithArr调用，对sorter配置
- (void)initializeSorter {
    if (_sortType == SortTypeBubble) {
        _sorter = [[BubbleSorter alloc] init];
    } else if (_sortType == SortTypeInsertion) {
        //_sorter = [[InsertionSorter alloc] init];
    } else if (_sortType == SortTypeSelection) {
        //_sorter = [[SelectionSorter alloc] init];
    } else if (_sortType == SortTypeHeap) {
        //_sorter = [[HeapSorter alloc] init];
    }
    
    
}

///为不同type的cell设置不同的size
- (void)updateItemSize {
    CGFloat w = self.view.width;
    CGFloat h = self.view.height;
    if (w > h) {
        w = h;
    } //w
    if (_sortType == SortTypeHeap) {
        h = (w - 2*_edgeDistance - 20)/2;
        _itemSize = CGSizeMake(h, h);
    } else {
        _itemSize = CGSizeMake(w - 2*_edgeDistance, 100);
    }
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _viewDataArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ELCollectionViewCell *cell;
    if (_sortType == SortTypeHeap) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(ELTreeUnitCell.class) forIndexPath:indexPath];
   
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(ELLinearUnitCell.class) forIndexPath:indexPath];
    }
    
    cell.dataArr = _viewDataArr[indexPath.item];
    //!!!!不知道为什么 重新开始一次演示的时候总是画不出来。后来发现drawRect没被调用，就让他needs display。 OK！
    [cell setNeedsDisplay];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _itemSize;
}

///行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 30;
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
    _originDataArr = 0;
    _viewDataArr = [[NSMutableArray alloc] init];
    [_collection reloadData];
}

- (void)dealloc {
    [Config removeObserver:self];
}



@end
