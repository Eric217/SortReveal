//
//  ViewController.m
//  SortReveal
//
//  Created by Eric on 2018/4/10.
//  Copyright © 2018 Eric. All rights reserved.
//


#import "Common.h"
#import "UIView+funcs.h"
#import "ViewController.h"
#import "UIView+frameProperty.h"
#import "ELSplitViewController.h"
#import "ELSortNameCollectionCell.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UILabel *appTitle;
@property (nonatomic, strong) IBOutlet UICollectionView *collection;

@property (nonatomic, strong) ELSplitViewController *splitVC;

@property (nonatomic, copy) NSMutableArray *titleArr;

@property (assign) CGFloat itemSize;
@property (assign) CGFloat edgeDistance; //20
@property (assign) CGFloat verticalSpacing; //36

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _edgeDistance = [Config v_pad:46 plus:36 p:28 min:20];
    _verticalSpacing = [Config v_pad:52 plus:33 p:24 min:20];
    
    NSArray *arr = [Config getArrayDataFromFile:SortNameFile];
    if (!arr) {
        arr = @[@"冒泡排序", @"选择排序", @"插入排序", @"堆排序"];
        [Config writeArrayToFile:SortNameFile data:arr];
    }
    _titleArr = arr.mutableCopy;
  
    _collection.delegate = self;
    _collection.dataSource = self;
    //列间距 item spacing不论怎么设置，最后系统都会自己调整，按照cell对称、不能显示一半等等得到最后spacing。
    [_collection registerClass:ELSortNameCollectionCell.class forCellWithReuseIdentifier:NSStringFromClass(ELSortNameCollectionCell.class)];
    
    
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
    ELSortNameCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(ELSortNameCollectionCell.class) forIndexPath:indexPath];
    NSString *content = indexPath.item == _titleArr.count ? @"添加" : _titleArr[indexPath.item];
    
    [cell fillContents:content];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    return CGSizeMake(_itemSize, _itemSize);
}

//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
//    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
//    if (IPAD) {
//        return;
//    }
//
//    if (size.width > size.height) {
//        _appTitle.height /= 2;
//
//    } else {
//        _appTitle.height *= 2;
//    }
//}

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
    CGFloat w;
    if (s.width > s.height) {
        w = s.height;
    } else {
        w = s.width;
    }
    
    if (IPAD) {
        _itemSize = (w-2*_edgeDistance-2*68)/3;
    } else {
        _itemSize = (w-3*_edgeDistance)/2;
    }
    
    
}



@end
