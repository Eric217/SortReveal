//
//  ViewController.m
//  SortReveal
//
//  Created by Eric on 2018/4/10.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"
#import "ELCollectionViewCell.h"
#import "UIView+frameProperty.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *appTitle;
@property (assign) CGFloat itemSize;
@property (nonatomic, copy) NSMutableArray *titleArr;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, 1).firstObject;
    docPath = [docPath stringByAppendingPathComponent:SortNameFile];
    
    if (!(_titleArr = [NSMutableArray arrayWithContentsOfFile:docPath])) {
        
        _titleArr = @[@"冒泡排序", @"插入排序", @"堆排序", @"选择排序"].mutableCopy;
        if (![_titleArr writeToFile:docPath atomically:0]) {
            [[NSFileManager defaultManager] removeItemAtPath:docPath error:nil];
        }
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 22;
    layout.minimumLineSpacing = 50;
    layout.itemSize = CGSizeMake(ScreenW/4-30, ScreenW/4-30);
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) collectionViewLayout:layout];
    _collection.delegate = self;
    _collection.dataSource = self;
    [_collection setBackgroundColor:UIColor.whiteColor];
    [_collection registerClass:ELCollectionViewCell.class forCellWithReuseIdentifier:@"cellid"];
    
    _collection.contentInset = UIEdgeInsetsMake(200, 30, 0, 30);

    [self.view addSubview:_collection];

    _appTitle = [[UILabel alloc] init];
    [_appTitle setText:@"排序"];
    [_appTitle setFont:[UIFont boldSystemFontOfSize:40]];
    [_appTitle setBackgroundColor:UIColor.clearColor];
    [_appTitle setTextColor:UIColor.blackColor];
    [_appTitle setTextAlignment:NSTextAlignmentCenter];
    [_collection addSubview:_appTitle];
    [_appTitle setFrame:CGRectMake(0, -200, ScreenW, 200)];
    
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.item) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        default:
            break;
    }
}






@end
