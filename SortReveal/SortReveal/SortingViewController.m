//
//  SortingViewController.m
//  SortReveal
//
//  Created by Eric on 2018/4/11.
//  Copyright © 2018 Eric. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "SortingViewController.h"
#import "UIView+funcs.h"
#import "UIView+frameProperty.h"
#import "UIViewController+funcs.h"
#import "SettingViewController.h"
#import "LinearSubSorters.h"
#import "Cells.h"

#define emptyDisplayString @"配置排序\n以开始"

//TODO: - save arrays in db

@interface SortingViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UIBarButtonItem *settings;

@property (strong, nonatomic) UICollectionView *collection;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIBarButtonItem *nextStepButton;
@property (strong, nonatomic) UIBarButtonItem *lastStepButton;
@property (strong, nonatomic) UIBarButtonItem *nextRowButton;
@property (strong, nonatomic) UIBarButtonItem *flowRunButton;
@property (strong, nonatomic) UILabel *collectionBackView;

@property (nonatomic, copy) NSMutableArray *originDataArr;
@property (nonatomic, copy) NSMutableArray<NSDictionary *> *viewDataDictArr;
@property (weak, nonatomic) NSTimer *timer;

@property (nonatomic, strong) id <Sorter> sorter;
@property (assign) SortType sortType;
@property (assign) SortOrder sortOrder;

@property (assign) CGFloat edgeDistance;
@property (assign) CGSize itemSize;

@end

@implementation SortingViewController

- (UIViewController *)primaryViewControllerForExpandingSplitViewController:(UISplitViewController *)splitViewController {
    
}

- (UIViewController *)primaryViewControllerForCollapsingSplitViewController:(UISplitViewController *)splitViewController {
    
    
}

//MARK: - 4 bottom control buttons
- (void)lastStep:(id)sender {
    int len = (int)(_viewDataDictArr.count);
 
    [_sorter lastStep];
    [_viewDataDictArr removeLastObject];
    [_collection deleteItemsAtIndexPaths:@[[Config idxPath:len-1]]];
    [self setEnabled:1];
    if (len < 3) {
        [_lastStepButton setEnabled:0];
    }
}

- (void)nextStep:(id)sender {
    if (!(_viewDataDictArr.count)) {
        return;
    }
    BOOL finished = false;
    [self nextSlide:[_sorter nextTurn:&finished] finished:finished];
}

- (void)nextRow:(id)sender {
    if (!(_viewDataDictArr.count))
        return;
    BOOL finished = 0;
    [self nextSlide:[_sorter nextRow:&finished] finished:finished];
}

- (void)nextSlide:(NSDictionary *)dict finished:(BOOL)finished {
    if (dict) {
        [_viewDataDictArr addObject:dict];
        NSIndexPath *idx = [Config idxPath:_viewDataDictArr.count-1];
        [_collection insertItemsAtIndexPaths:@[idx]];
        [_collection scrollToItemAtIndexPath:idx atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:1];
        [_lastStepButton setEnabled:1];
    }
    if (finished) {
        [self setEnabled:0];
        [self stop:0];
    }
}


- (void)play:(id)sender {
    if (!(_viewDataDictArr.count)) {
        return;
    }
    NSString *pause = @"暂停演示";
    if ([_flowRunButton.title isEqualToString:pause]) {
        [self stop:sender];
    } else {
        [_flowRunButton setTitle:pause];
        NSString *exeway = [NSUserDefaults.standardUserDefaults stringForKey:kFlowExecWay];
        SEL func;
        if ([exeway isEqualToString:SingleStep]) {
            func = @selector(nextStep:);
        } else {
            func = @selector(nextRow:);
        }
        _timer = [NSTimer scheduledTimerWithTimeInterval:[NSUserDefaults.standardUserDefaults doubleForKey:kTimeInterval]  target:self selector:func userInfo:0 repeats:1];
        [_timer fire];
    }
}

- (void)stop:(id)sender {
    [_timer invalidate];
    [_flowRunButton setTitle:@"顺序执行"];
}

//MARK: - 2 top buttons

///点击展示界面上的返回按钮
- (void)clickBack:(id)sender {
    //TODO: - 
    [Config postNotification:ELSplitVCShouldDismissNotification message:nil];

}

- (void)restart:(id)sender {
    [self initializeWithArr:_originDataArr type:self.sortType order:self.sortOrder];

    
}

- (void)openSettings:(id)sender {
    [self pushWithoutBottomBar:[[SettingViewController alloc] init]];
}

//MARK: - So many initializers
///点击展示按钮后，如果正在展示则询问，否则直接展示原始数据第一单元。prepare后调用initialize来开始。
- (void)prepareDisplay:(NSNotification *)noti {
    
    short t = ((NSNumber *)(noti.userInfo[kSortType])).shortValue;
    short o = ((NSNumber *)(noti.userInfo[kSortOrder])).shortValue;
    
    if (_originDataArr && _originDataArr.count) {
        NSString *msg = @"有演示中的排序。要开始新的排序吗";
        [self presentAlertWithConfirmTitle:@"提醒" message:msg Action:^(UIAlertAction *_) {
            [self initializeWithArr:noti.userInfo[kDataArr] type:t order:o];
        }];
    } else
        [self initializeWithArr:noti.userInfo[kDataArr] type:t order:o];
}

///由prepare或restart调用，展示开始的唯一入口，参数: 原始数组、排序种类、顺序方式
- (void)initializeWithArr:(NSMutableArray *)arr type:(SortType)t order:(SortOrder)o {
    _sortType = t;
    _sortOrder = o;
    _originDataArr = arr;
    _viewDataDictArr = [[NSMutableArray alloc] init];
    
    [self initializeSorter];
    [self updateItemSize];
    [self initButtonState:arr.count > 1];

    if (arr.count != 0) {
        NSArray *posi = [self getInitialPositions];
        NSArray *titl = [self getInitialTitles];
        [_viewDataDictArr addObject:@{kDataArr: _originDataArr, kPositionArr: posi, kTitleArr: titl}];
        _collectionBackView.text = @"";
    } else {
        _collectionBackView.text = emptyDisplayString;
    }

    [self.navigationController popToRootViewControllerAnimated:1];
    [_collection reloadData];
}

- (NSArray *)getInitialPositions {
    if (_originDataArr.count <= 1) {
        return 0;
    } else if (_sortType == SortTypeBubble) {
        return @[@"0", @"1", [NSString stringWithFormat:@"%d", (int)(_originDataArr.count)]];
    } else if (_sortType == SortTypeSelection) {
        return @[@"0", @"1"];
    } else if (_sortType == SortTypeInsertion) {
        return @[ ];
    } else if (_sortType == SortTypeHeap) {
        return @[ ];
    } else if (_sortType == SortTypeFast) {
        
    }
    return 0;
}

- (NSArray *)getInitialTitles {
    if (_originDataArr.count <= 1) {
        return 0;
    } else if (_sortType == SortTypeBubble) {
        return @[@"j", @"j+1", @"i"];
    } else if (_sortType == SortTypeSelection) {
        return @[@"i", @"j"];
    } else if (_sortType == SortTypeInsertion) {
        return @[ ];
    } else if (_sortType == SortTypeHeap) {
        return @[ ];
    } else if (_sortType == SortTypeFast) {
        
    }
    return 0;
}

///由initializeWithArr调用，对sorter配置
- (void)initializeSorter {
    if (_sortType == SortTypeBubble) {
        _sorter = [[BubbleSorter alloc] init];
    } else if (_sortType == SortTypeInsertion) {
        _sorter = [[InsertionSorter alloc] init];
    } else if (_sortType == SortTypeSelection) {
        _sorter = [[SelectionSorter alloc] init];
    } else if (_sortType == SortTypeHeap) {
        _sorter = [[HeapSorter alloc] init];
    } else if (_sortType == SortTypeFast) {
        _sorter = [[FastSorter alloc] init];
    }
   
    [_sorter initializeWithArray:_originDataArr order:_sortOrder]; //inside deep
    
}

//MARK: - other funcs
- (void)clearContent {
   
    _originDataArr = 0;
    _viewDataDictArr = [[NSMutableArray alloc] init];
    _collectionBackView.text = emptyDisplayString;

    //TODO: - 以后熟悉了splitViewController这里可能要改。用pop会警告
    //[self.navigationController popToRootViewControllerAnimated:0];
    
    NSMutableArray *vcs = [self.navigationController.viewControllers mutableCopy];
    while (![vcs.lastObject isKindOfClass:SortingViewController.class])
         [vcs removeLastObject];
    [self.navigationController setViewControllers:vcs];
    [_collection reloadData];
    [self initButtonState:1];
}

- (void)initButtonState:(BOOL)state {
    [_lastStepButton setEnabled:0];
    [self stop:0];
    [self setEnabled:state];
}

- (void)dealloc {
    [Config removeObserver:self];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [Config postNotification:ELTextFieldShouldResignNotification message:0];
}


//MARK: - View and Collection View

- (void)setEnabled:(bool)b {
    [_nextRowButton setEnabled:b];
    [_nextStepButton setEnabled:b];
    [_flowRunButton setEnabled:b];
}

///为不同type的cell设置不同的 item size
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
    return _viewDataDictArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ELCollectionViewCell *cell;
    if (_sortType == SortTypeHeap) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(ELTreeUnitCell.class) forIndexPath:indexPath];
   
    } else if (_sortType == SortTypeBubble || _sortType == SortTypeSelection){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(ELCommonLinearCell.class) forIndexPath:indexPath];
    } else if (_sortType == SortTypeInsertion) {
        
    } else if (_sortType == SortTypeFast) {
        
    }
    
    cell.dataDict = _viewDataDictArr[indexPath.item];
    //!!!!不知道为什么 重新开始一次演示的时候总是画不出来。后来发现drawRect没被调用，就让他needs display。 OK！
    [cell setNeedsDisplay];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _itemSize;
}

///行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 24;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //buttons
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 6, 92, 32)];
    [_backButton setContentEdgeInsets:UIEdgeInsetsMake(0, IPAD ? -14 : -20, 0, 0)];
    [_backButton setTitle:@"配置排序" forState:UIControlStateNormal];
    [_backButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [_backButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [_backButton setImage:[Config backImage] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBackItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    //self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    self.navigationItem.leftBarButtonItems = @[customBackItem];
    
    UIBarButtonItem *restart = [[UIBarButtonItem alloc] initWithTitle:@"重新开始" style:UIBarButtonItemStylePlain target:self action:@selector(restart:)];
    [restart setTintColor:UIColor.blackColor];
    _settings = [[UIBarButtonItem alloc] initWithTitle:@" 设置" style:UIBarButtonItemStylePlain target:self action:@selector(openSettings:)];
    [_settings setTintColor:UIColor.blackColor];
    self.navigationItem.rightBarButtonItems = @[_settings, restart];
    
    _lastStepButton = [[UIBarButtonItem alloc] initWithTitle:@"上一步" style:UIBarButtonItemStylePlain target:self action:@selector(lastStep:)];
    _flowRunButton = [[UIBarButtonItem alloc] initWithTitle:@"顺序执行" style:UIBarButtonItemStylePlain target:self action:@selector(play:)];
    _nextRowButton = [[UIBarButtonItem alloc] initWithTitle:@"单组跳过" style:UIBarButtonItemStylePlain target:self action:@selector(nextRow:)];
    CGFloat www; NSString *nextStepStr;
    if (IPHONE4 || IPHONE5) {
        www = 0; nextStepStr = @"下一步";
    } else {
        www = 42; nextStepStr = @"单步执行";
    }
    _nextStepButton = [[UIBarButtonItem alloc] initWithTitle:nextStepStr style:UIBarButtonItemStylePlain target:self action:@selector(nextStep:)];
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:0 action:0];
    [fixedSpace setWidth:www];
    self.toolbarItems = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:0 action:0], _lastStepButton, fixedSpace, _flowRunButton, _nextRowButton, _nextStepButton];
    
    //collection view
    _edgeDistance = [Config v_pad:30 plus:15 p:10 min:10];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [_collection setBackgroundColor:UIColor.whiteColor];
    [_collection setAllowsSelection:0];
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.alwaysBounceVertical = 1;
    _collection.contentInset = UIEdgeInsetsMake(38.5, _edgeDistance, 24, _edgeDistance);
    [_collection registerClass:ELTreeUnitCell.class forCellWithReuseIdentifier:NSStringFromClass(ELTreeUnitCell.class)];
    [_collection registerClass:ELCommonLinearCell.class forCellWithReuseIdentifier:NSStringFromClass(ELCommonLinearCell.class)];
    [_collection registerClass:ELRepeatLinearCell.class forCellWithReuseIdentifier:NSStringFromClass(ELRepeatLinearCell.class)];
    [_collection registerClass:ELGroupedUnitCell.class forCellWithReuseIdentifier:NSStringFromClass(ELGroupedUnitCell.class)];
//    [_collection registerClass:ELLinearUnitCell.class forCellWithReuseIdentifier:NSStringFromClass(ELLinearUnitCell.class)];
    [self.view addSubview:_collection];
    [_collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
    
    _collectionBackView = [[UILabel alloc] init];
    [_collection insertSubview:_collectionBackView atIndex:0];
    UIColor *tc = [UIColor.grayColor colorWithAlphaComponent:0.78];
    [_collectionBackView setTextColor:tc];
    _collectionBackView.text = emptyDisplayString;
    _collectionBackView.numberOfLines = 2;
    _collectionBackView.font = [UIFont systemFontOfSize:28];
    _collectionBackView.textAlignment = NSTextAlignmentCenter;
    [_collectionBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.collection);
        make.centerY.equalTo(self.collection.mas_centerY).mas_offset(-122);
        make.size.mas_equalTo(CGSizeMake(300, 200));
    }];
 
    //user defaults
    if ([UserDefault doubleForKey:kTimeInterval] <= 0) {
        [Config saveDouble:1.5 forKey:kTimeInterval];
    }
    if (![UserDefault stringForKey:kFlowExecWay]) {
        [UserDefault setObject:SingleStep forKey:kFlowExecWay];
        [UserDefault synchronize];
    }
    
    //other settings
    [self setTitle:@"动态演示"];
    [Config addObserver:self selector:@selector(prepareDisplay:) notiName:SortingVCShouldStartDisplayNotification];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stop:0];
}

@end
