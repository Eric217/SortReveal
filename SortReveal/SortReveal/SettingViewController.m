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

@interface SettingViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *table;
//@property (nonatomic, copy) NSMutableArray<NSMutableArray *> *array;

@end

@implementation SettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:UIColor.blackColor];
    [self setTitle:@"演示设置"];

    _table.delegate = self;
    _table.dataSource = self;
    //[_table registerClass:SwitchCell.class forCellReuseIdentifier:NSStringFromClass(SwitchCell.class)];
    [_table registerClass:UITableViewHeaderFooterView.class forHeaderFooterViewReuseIdentifier:@"headerid"];
    [_table setRowHeight:50];
    
//    NSArray<NSArray *> *arr = [Config getArrayDataFromFile:SortOrderFile];
//    if (!arr) {
//        arr = @[@[@"顺序执行时间间隔", @"跳过没有发生交换的步骤", @"数值大小"], @[@"字符升序", @"字符降序", @"字符顺序"], @[@"字典升序", @"字典降序", @"字典顺序"], @[@"自动推断", @" "]];
//        [Config writeArrayToFile:SortOrderFile data:arr];
//    }
    
 
}

- (void)didChangeSkipNull:(UISwitch *)sender {
    NSLog(@"%d", [sender isOn]);
    [NSUserDefaults.standardUserDefaults setBool:sender.isOn forKey:kSkipNullStep];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            SwitchCell *cell =  [[SwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(SwitchCell.class)];
            [cell.switcher addTarget:self action:@selector(didChangeSkipNull:) forControlEvents:UIControlEventValueChanged];
            [[cell switcher] setOn:[NSUserDefaults.standardUserDefaults boolForKey:kSkipNullStep]];
            [[cell textLabel] setText:@"跳过没有发生交换的步骤"];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        } else if (indexPath.row == 1) {
            TextFieldCell *cell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(TextFieldCell.class)];
            [cell.textLabel setText:@"顺序执行时间间隔"];
            cell.textField.delegate = self;
            return cell;
        }
        
    } else if (indexPath.section == 1) {
        
    } else {
        
    }
    
    //[[cell textLabel] setText:_array[indexPath.section][indexPath.row]];
    //if (indexPath.section == _array.count-1) {
     //   [[cell textLabel] setTextColor:systemBlue];
    //}
 
    return 0;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 44;
    }
    return 33;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return 0;
    //UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerid"];

    //return headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;

   // return _array[section].count-1;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_table endEditing:1];
    [Config postNotification:ELTextFieldShouldResignNotification message:0];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            [tableView deselectRowAtIndexPath:indexPath animated:1];
            TextFieldCell *textFiel = [tableView cellForRowAtIndexPath:indexPath];
            [textFiel becomeFirstResponder];
            
        }
    }

}



@end
