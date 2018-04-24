//
//  TextFieldCell.m
//  SortReveal
//
//  Created by Eric on 2018/4/23.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "TextFieldCell.h"
#import <Masonry/Masonry.h>


@interface TextFieldCell ()

@property (nonatomic, strong) UISwitch *switcher;

@end


@implementation TextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _textField = [[UITextField alloc] init];
        [self.contentView addSubview:_textField];
        UILabel *l = [[UILabel alloc] init];
        [l setText:@"秒"];
        [l setTextColor:UIColor.lightGrayColor];
        [self.contentView addSubview:l];
        [l mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).inset(10);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(24, 45));
        }];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(l.mas_left).inset(10);
            make.centerY.height.equalTo(l);
            make.width.mas_equalTo(100);
        }];
        [_textField setTextAlignment:NSTextAlignmentRight];
        [_textField setKeyboardType:UIKeyboardTypeNumberPad];
    }
    return self;
    
}

@end
