//
//  ViewController.m
//  SortReveal
//
//  Created by Eric on 2018/4/10.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"
#import "ELSplitViewController.h"
#import "ELCollectionViewCell.h"
#import "UIView+frameProperty.h"
 
@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UILabel *appTitle;

@property (nonatomic, strong) ELSplitViewController *splitVC;

@property (nonatomic, copy) NSMutableArray *titleArr;

@property (assign) CGFloat itemSize;
@property (assign) CGFloat edgeDistance; //20
@property (assign) CGFloat horizontalSpacing; //44
@property (assign) CGFloat verticalSpacing; //36
@property (assign) int colPerRow;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _edgeDistance = [Config v_pad:46 plus:15 p:10];
    _horizontalSpacing = [Config v_pad:66 plus:24 p:18];
    _verticalSpacing = [Config v_pad:52 plus:20 p:14];
    
    NSArray *arr = [Config getSortNameArray];
    if (!arr) {
        arr = @[@"冒泡排序", @"选择排序", @"插入排序", @"堆排序"];
        [Config writeSortNameArray:arr];
    }
    _titleArr = arr.mutableCopy;
   
    _collection.delegate = self;
    _collection.dataSource = self;
    //列间距 item spacing不论怎么设置，最后系统都会自己调整，按照cell对称、不能显示一半等等得到最后spacing。
    [_collection registerClass:ELCollectionViewCell.class forCellWithReuseIdentifier:@"cellid"];
    
    
    _collection.alwaysBounceVertical = 1;
    _collection.contentInset = UIEdgeInsetsMake(15, _edgeDistance, 15, _edgeDistance);
 
    [_appTitle setText:@"排序"];
    [_appTitle setFont:[UIFont boldSystemFontOfSize:40]];
   
    
}

- (void)dismiss {
    
   
    [self.view.window setRootViewController:self];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titleArr.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ELCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    NSString *content = indexPath.item == _titleArr.count ? @"添加" : _titleArr[indexPath.item];
  
    [cell fillContents:content];
    
    return cell;
}



- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    if (size.width != self.view.width) {
        _colPerRow = size.width > size.height ? 4 : 3;
        [_collection reloadData];
    }
  
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat s = ScreenW-2*_edgeDistance-(_colPerRow-1)*_horizontalSpacing;
    s /= _colPerRow;
    return CGSizeMake(s, s);
}


///行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return _verticalSpacing;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!_splitVC) {
        _splitVC = [[ELSplitViewController alloc] init];
        _splitVC.backVC = self;
    }
    NSInteger idx = indexPath.item;
    
    if (idx < 4) {
        [_splitVC initOrResetContent:indexPath.item];
        [self.view.window setRootViewController:_splitVC];
    }
 
}

//比collection view的代理方法先执行
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
   
    const CGSize s = self.view.frame.size;
    _colPerRow = s.width > s.height ? 4 : 3;
  
}



@end
