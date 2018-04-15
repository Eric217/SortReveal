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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
 
        _titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel setFont:[UIFont fontWithName:@"PingFang SC" size:24]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        _titleLabel.layer.cornerRadius = 3;
        _titleLabel.clipsToBounds = 1;
        _titleLabel.layer.borderColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.7].CGColor;
        _titleLabel.layer.borderWidth = 1.5;
  
    }
    
    return self;
}



- (void)fillContents:(id)content {
    [_titleLabel setFrame:self.bounds];
    
    [self.titleLabel setText:content];
}

@end
