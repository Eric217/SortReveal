//
//  RightLabelCell.m
//  SortReveal
//
//  Created by Eric on 2018/4/24.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "RightLabelCell.h"
#import <Masonry/Masonry.h>

@implementation RightLabelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _rightLabel = [[UILabel alloc] init];
        [self addSubview:_rightLabel];
 
        [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-27);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(120, 45));
        }];
        [_rightLabel setTextAlignment:NSTextAlignmentRight];
        [_rightLabel setTextColor:UIColor.lightGrayColor];
    }
    return self;
    
}

@end
