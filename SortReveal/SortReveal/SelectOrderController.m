//
//  SelectOrderControllerTableViewController.m
//  SortReveal
//
//  Created by Eric on 2018/4/16.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "SelectOrderController.h"
#import "Common.h"

@interface SelectOrderController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, copy) NSMutableArray<NSMutableArray *> *array;


@end

@implementation SelectOrderController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"排序方式"];
    _table.delegate = self;
    _table.dataSource = self;
    [_table registerClass:UITableViewCell.class forCellReuseIdentifier:@"cellid"];
    [_table registerClass:UITableViewHeaderFooterView.class forHeaderFooterViewReuseIdentifier:@"headerid"];
    [_table setSectionHeaderHeight:48];
    [_table setTableHeaderView:[[UIView alloc] init]];
    [_table setContentOffset:CGPointMake(0, 30)];
    
    NSArray<NSArray *> *arr = [Config getArrayDataFromFile:SortOrderFile];
    if (!arr) {
        arr = @[@[@"数值升序", @"数值降序", @"数值大小"], @[@"字符升序", @"字符降序", @"字符顺序"], @[@"字典升序", @"字典降序", @"字典顺序"], @[@"自动推断", @" "]];
        [Config writeArrayToFile:SortOrderFile data:arr];
    }
    _array = [arr mutableCopy];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerid"];
    NSMutableArray *temp = _array[section];
    [headerView.textLabel setText:temp[temp.count-1]];
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _array[section].count-1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    [[cell textLabel] setText:_array[indexPath.section][indexPath.row]];
    if (indexPath.section == _array.count-1) {
        [[cell textLabel] setTextColor:systemBlue];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger sec = indexPath.section;
    NSInteger ro = indexPath.row;
    NSString *idx = NSStringFromCGPoint(CGPointMake(sec, ro));
    NSArray *data = [NSArray arrayWithObjects:idx, _array[sec][ro], nil];
    [_delegate transferData:data];
    
    [tableView deselectRowAtIndexPath:indexPath animated:1];
    [self.navigationController popViewControllerAnimated:1];
}







@end
