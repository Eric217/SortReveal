//
//  ELCollectionViewCell.m
//  SortReveal
//
//  Created by Eric on 2018/4/10.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "ELCollectionViewCell.h"
#import "UIView+frameProperty.h"

@interface ELCollectionViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ELCollectionViewCell

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:<#(CGRect)#>];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel setFont:[UIFont fontWithName:@"San Francisco" size:25]];
    }
    return _titleLabel;
}

- (void)fillContents:(id)content {
    [_titleLabel setFrame:self.contentView.bounds];
    [self.titleLabel setText:content];
}

@end
