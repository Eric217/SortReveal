//
//  SelectOrderControllerTableViewController.m
//  SortReveal
//
//  Created by Eric on 2018/4/16.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "SelectOrderController.h"
#import "Common.h"
#import <Masonry/Masonry.h>

@interface SelectOrderController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *table;
@property (nonatomic, copy) NSMutableArray<NSMutableArray *> *array;


@end

@implementation SelectOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:UIColor.blackColor];
    [self setTitle:@"排序方式"];
    
    _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_table];
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
    
    _table.delegate = self;
    _table.dataSource = self;
    [_table registerClass:UITableViewCell.class forCellReuseIdentifier:@"cellid"];
    [_table registerClass:UITableViewHeaderFooterView.class forHeaderFooterViewReuseIdentifier:@"headerid"];
 
    NSArray<NSArray *> *arr = [Config getArrayDataFromFile:SortOrderFile];
    if (!arr) {
        arr = @[@[@"数值升序", @"数值降序", @"数值大小"], @[@"字符升序", @"字符降序", @"字符顺序"], @[@"字典升序", @"字典降序", @"字典顺序"], @[@"自动推断", @" "]];
        [Config writeArrayToFile:SortOrderFile data:arr];
    }
    _array = [arr mutableCopy];
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 72;
    }
    return 45;
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
    NSNumber *order = [NSNumber numberWithLong:(indexPath.section * 10 + indexPath.row)];
    NSArray *data = [NSArray arrayWithObjects:order, _array[indexPath.section][indexPath.row], nil];
    [_delegate transferData:data];
    
    [tableView deselectRowAtIndexPath:indexPath animated:1];
    [self.navigationController popViewControllerAnimated:1];
}







@end
