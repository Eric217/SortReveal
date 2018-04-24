//
//  SettingViewController.m
//  SortReveal
//
//  Created by Eric on 2018/4/23.
//  Copyright © 2018 Eric. All rights reserved.
//


#import "SelectFlowController.h"

@interface SelectFlowController ()

@property (nonatomic, copy) NSArray<NSString *> *dataArr;

@end

@implementation SelectFlowController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.navigationController.navigationBar setTintColor:UIColor.blackColor];
    [self setTitle:@"顺序执行方式"];
 
    [self.table registerClass:UITableViewCell.class forCellReuseIdentifier:@"cellid"];
    [self.table setRowHeight:50];
 
    _dataArr = @[SingleStep, GroupStep];
    
}


//MARK: - table view
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    [[cell textLabel] setText:_dataArr[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:1];
    [[self navigationController] popViewControllerAnimated:1];
    [self.delegate transferData:_dataArr[indexPath.row]];
}



//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return 44;
//    }
//    return 33;
//}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return 0;
//    //UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerid"];
//
//    //return headerView;
//}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return 2;
//}




@end