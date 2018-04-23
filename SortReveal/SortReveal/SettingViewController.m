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

@interface SettingViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) UITableView *table;
//@property (nonatomic, copy) NSMutableArray<NSMutableArray *> *array;

@end

@implementation SettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:1];
    return 1;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSUserDefaults * d = [NSUserDefaults standardUserDefaults];
    double interval = textField.text.doubleValue;
    
    if (interval < 0.3 || interval > 10) {
        textField.text = @"0.8";
    } else {
        [d setDouble:interval forKey:kTimeInterval];
        [d synchronize];
    }
    return 1;
}

//MARK: - table view
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
            double ti = [[NSUserDefaults standardUserDefaults] doubleForKey:kTimeInterval];
            if (ti <= 0) {
                [NSUserDefaults.standardUserDefaults setDouble:0.8 forKey:kTimeInterval];
                [NSUserDefaults.standardUserDefaults synchronize];
                [cell.textField setText:@"0.8"];
            } else {
                [cell.textField setText:[NSString stringWithFormat:@"%.2f", ti]];
            }
            return cell;
        }
        
    } else if (indexPath.section == 1) {
        
    } else {
        
    }
    

    return 0;
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
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
 
    [Config postNotification:ELTextFieldShouldResignNotification message:0];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            [tableView deselectRowAtIndexPath:indexPath animated:1];
            TextFieldCell *textFiel = [tableView cellForRowAtIndexPath:indexPath];
            [textFiel.textField becomeFirstResponder];
            
        }
    }

}



@end
