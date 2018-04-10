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
    
    
    
    
    
}

- (UICollectionView *)collection {
    if (!_collection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 50;
        layout.itemSize = CGSizeMake(ScreenW/4-30, ScreenW/4-30);
        _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        [_collection registerClass:ELCollectionViewCell.class forCellWithReuseIdentifier:@"cellid"];
        [self.view addSubview:_collection];
    }
    return _collection;
}

- (UILabel *)appTitle {
    if (!_appTitle) {
        _appTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        [_appTitle setText:@"排序"];
        [_appTitle setTextColor:UIColor.blackColor];
        //[_appTitle setAttributedText:nil];
    
        //[self.view addSubview:_appTitle];
    }
    return _appTitle;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [_collection setFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    //[_appTitle setCenterX:self.view.centerX];
    //_appTitle setCenterY:<#(CGFloat)#>
}

- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, 1).firstObject;
        docPath = [docPath stringByAppendingPathComponent:SortNameFile];
        NSLog(@"%@", docPath);
        if (!(_titleArr = [NSMutableArray arrayWithContentsOfFile:docPath])) {
            
            _titleArr = [@"冒泡排序|插入排序|堆排序|选择排序" componentsSeparatedByString:@"|"].mutableCopy;
            if (![_titleArr writeToFile:docPath atomically:0]) {
                [[NSFileManager defaultManager] removeItemAtPath:docPath error:nil];
            }
        }
        
    }
    return _titleArr;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ELCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    [cell fillContents:_titleArr[indexPath.item]];
    
    return cell;
}








@end
