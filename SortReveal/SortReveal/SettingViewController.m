//
//  SettingViewController.m
//  SortReveal
//
//  Created by Eric on 2018/4/23.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "Common.h"
#import "SettingViewController.h"
#import "SwitchCell.h"
#import "TextFieldCell.h"
#import <Masonry/Masonry.h>
#import "Protocols.h"
#import "SelectFlowController.h"

@interface SettingViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, SimpleTransfer>

@property (strong, nonatomic) UITableView *table;
@property (nonatomic, copy) NSArray<NSArray *> *array;


@end

@implementation SettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //works only on ipad
    [self.navigationController.navigationBar setTintColor:UIColor.blackColor];
    [self setTitle:@"演示设置"];
    
    _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:_table];
    [_table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
    
    _table.delegate = self;
    _table.dataSource = self;
  
    [_table registerClass:UITableViewHeaderFooterView.class forHeaderFooterViewReuseIdentifier:@"headerid"];
    [_table setRowHeight:50];
    
    _array = @[@[@"跳过没有发生交换的步骤", @"如果当前步骤不会发生交换，则跳过并执行下一步"],
               @[@"顺序执行时间间隔", @"顺序执行时单步或单组跳过", @"顺序执行设置"],
               @[@"智能比较字母与数字", @"字符或字典排序时，例如 Foo2 < Foo7 < Foo25"]
             ];
    [Config postNotification:ELTextFieldShouldResignNotification message:0];
    [Config addObserver:self selector:@selector(resignResponder) notiName:ELTextFieldShouldResignNotification];
 
 
}
//MARK: - 业务需求处理

- (void)resignResponder {
    [_table endEditing:1];
}

- (void)didChangeSkipNull:(UISwitch *)sender {
    [NSUserDefaults.standardUserDefaults setBool:sender.isOn forKey:kSkipNullStep];
    [NSUserDefaults.standardUserDefaults synchronize];
}

- (void)didChangeNumericCompare:(UISwitch *)sender {
    [NSUserDefaults.standardUserDefaults setBool:sender.isOn forKey:kNumericCompare];
    [NSUserDefaults.standardUserDefaults synchronize];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:1];
    return 1;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length == 8) {
        return 0;
    }
    return 1;
}



- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    
    NSString *origiText = [NSString stringWithFormat:@"%.2f", [d doubleForKey:kTimeInterval]];

    double interval = [Config doubleValue:textField.text];
    if (interval < 0.3 || interval > 10) {
        textField.text = origiText;
    } else {
        [d setDouble:interval forKey:kTimeInterval];
        [d synchronize];
    }
    return 1;
}

- (void)dealloc
{
    [Config removeObserver:self];
}

//MARK: - table view
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *tableCell;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            SwitchCell *cell =  [[SwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(SwitchCell.class)];
            [cell.switcher addTarget:self action:@selector(didChangeSkipNull:) forControlEvents:UIControlEventValueChanged];
            [[cell switcher] setOn:[NSUserDefaults.standardUserDefaults boolForKey:kSkipNullStep]];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            tableCell = cell;
        }
        
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            TextFieldCell *cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(TextFieldCell.class)];
            cell.textField.delegate = self;
            double ti = [[NSUserDefaults standardUserDefaults] doubleForKey:kTimeInterval];
            [cell.textField setText:[NSString stringWithFormat:@"%.2f", ti]];
            tableCell = cell;
            
        } else if (indexPath.row == 1) {
 
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellid"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults] stringForKey:kFlowExecWay];
 
            tableCell = cell;
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            SwitchCell *cell =  [[SwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(SwitchCell.class)];
            [cell.switcher addTarget:self action:@selector(didChangeNumericCompare:) forControlEvents:UIControlEventValueChanged];
            [[cell switcher] setOn:[NSUserDefaults.standardUserDefaults boolForKey:kNumericCompare]];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            tableCell = cell;
        }
    }
    tableCell.textLabel.text = _array[indexPath.section][indexPath.row];

    return tableCell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 54;
    }
    return 33;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerid"];
    NSUInteger c = _array[section].count;
    headerView.textLabel.text = _array[section][c-1];
    return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array[section].count-1;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
 
    [Config postNotification:ELTextFieldShouldResignNotification message:0];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [tableView deselectRowAtIndexPath:indexPath animated:1];
        if (indexPath.row == 0) {
            TextFieldCell *textFiel = [tableView cellForRowAtIndexPath:indexPath];
            [textFiel.textField becomeFirstResponder];
        } else if (indexPath.row == 1) {
            SelectFlowController *vc = [[SelectFlowController alloc] init];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:1];
        }
        
    }

}

- (void)transferData:(id)data {
    UITableViewCell *cell = [_table cellForRowAtIndexPath:[Config idxPathS:1 item:1]];
    
    if (cell.detailTextLabel.text != data) {
        cell.detailTextLabel.text = data;
        [NSUserDefaults.standardUserDefaults setObject:data forKey:kFlowExecWay];
        [NSUserDefaults.standardUserDefaults synchronize];
    }
}


@end
