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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.splitViewController.presentsWithGesture = 0;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.splitViewController.presentsWithGesture = 1;
}


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
    
    _array = @[@[@"跳过没有发生交换的步骤", @"如果当前步骤不会发生交换，则跳过并执行下一步(部分排序中有效)"], //1+1
               @[@"顺序执行时间间隔", @"顺序执行时单步或单组跳过", @"顺序执行设置"], //2+1
               @[@"智能比较字母与数字", @"使用最小堆演示堆排序", @"字符或字典排序时，使 Foo2 < Foo7 < Foo25"], //2+1
               @[@"自动推断排序方式时升序", @"忽略字母大小写", @""], //2+1
             ];
    [Config postNotification:ELTextFieldShouldResignNotification message:0];
    [Config addObserver:self selector:@selector(resignResponder) notiName:ELTextFieldShouldResignNotification];
 
 
}
//MARK: - 业务需求处理

- (void)resignResponder {
    [_table endEditing:1];
}

- (void)didChangeSkipNull:(UISwitch *)sender {
    [Config saveDouble:sender.isOn forKey:kSkipNullStep];
}

- (void)didChangeNumericCompare:(UISwitch *)sender {
    [Config saveDouble:sender.isOn forKey:kNumericCompare];
}

- (void)didChangePreferredHeap:(UISwitch *)sender {
    [Config saveDouble:sender.isOn forKey:kPreferMinHeap];
}

- (void)didChangeAutomaticOrder:(UISwitch *)sender {
    [Config saveDouble:!(sender.isOn) forKey:kAutomaticOrderASD];
}

- (void)didChangeIgnoringCases:(UISwitch *)sender {
    [Config saveDouble:sender.isOn forKey:kIgnoringCases];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:1];
    return 1;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    UITextPosition *end = [textField endOfDocument];
    UITextPosition *start = [textField positionFromPosition:end offset:-textField.text.length];
    textField.selectedTextRange = [textField textRangeFromPosition:start toPosition:end];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length == 8) {
        return 0;
    }
    return 1;
}
 
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
 
    NSString *origiText = [NSString stringWithFormat:@"%.2f", [UserDefault doubleForKey:kTimeInterval]];

    double interval = [Config doubleValue:textField.text];
    if (interval < 0.3 || interval > 10) {
        textField.text = origiText;
    } else {
        [Config saveDouble:interval forKey:kTimeInterval];
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
            tableCell = [self switchCellWithAction:@selector(didChangeSkipNull:) isOn:[UserDefault boolForKey:kSkipNullStep]];
        }
        
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            TextFieldCell *cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(TextFieldCell.class)];
            cell.textField.delegate = self;
            double ti = [UserDefault doubleForKey:kTimeInterval];
            [cell.textField setText:[NSString stringWithFormat:@"%.2f", ti]];
            tableCell = cell;
            
        } else if (indexPath.row == 1) {
 
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellid"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            int exew = [UserDefault stringForKey:kFlowExecWay].intValue;
            if (exew == ExecuteWayStep) {
                
                cell.detailTextLabel.text =  SingleStep;
            } else {
                cell.detailTextLabel.text = GroupStep;
            }
            tableCell = cell;
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            tableCell = [self switchCellWithAction:@selector(didChangeNumericCompare:) isOn:[UserDefault boolForKey:kNumericCompare]];
        } else if (indexPath.row == 1) {
            tableCell = [self switchCellWithAction:@selector(didChangePreferredHeap:) isOn:[UserDefault boolForKey:kPreferMinHeap]];
        }
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            tableCell = [self switchCellWithAction:@selector(didChangeAutomaticOrder:) isOn:![UserDefault boolForKey:kAutomaticOrderASD]];
        } else if (indexPath.row == 1) {
            tableCell = [self switchCellWithAction:@selector(didChangeIgnoringCases:) isOn:[UserDefault boolForKey:kIgnoringCases]];
        }
    }
    
    tableCell.textLabel.text = _array[indexPath.section][indexPath.row];

    return tableCell;
}

- (SwitchCell *)switchCellWithAction:(SEL)action isOn:(BOOL)on {
    SwitchCell *cell =  [[SwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(SwitchCell.class)];
    [cell.switcher addTarget:self action:action forControlEvents:UIControlEventValueChanged];
    [[cell switcher] setOn:on];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 66;
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
            vc.currentSelection = [[tableView cellForRowAtIndexPath:indexPath] detailTextLabel].text;
            [self.navigationController pushViewController:vc animated:1];
        }
        
    }

}

- (void)transferData:(id)data {
    UITableViewCell *cell = [_table cellForRowAtIndexPath:IndexPath(1, 1)];
    NSString *r;
    if (((NSString *)data).intValue == ExecuteWayStep) {
        r = SingleStep;
    } else {
        r = GroupStep;
    }
    
    if (cell.detailTextLabel.text != r) {
        cell.detailTextLabel.text = r;
        [NSUserDefaults.standardUserDefaults setObject:data forKey:kFlowExecWay];
        [NSUserDefaults.standardUserDefaults synchronize];
    }
}


@end
