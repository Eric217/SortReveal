//
//  SwitchTableViewCell.m
//  SortReveal
//
//  Created by Eric on 2018/4/23.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "SwitchCell.h"
#import <Masonry/Masonry.h>

 
@implementation SwitchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _switcher = [[UISwitch alloc] init];
        [self.contentView addSubview:_switcher];
        //尽管apple推荐update里update
        [_switcher mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).inset(20);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
    
}

- (void)addTarget:(id)target action:(nonnull SEL)action {
    [_switcher addTarget:target action:action forControlEvents:UIControlEventValueChanged];
}

@end

