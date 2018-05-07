//
//  ELGroupedUnitCell.m
//  SortReveal
//
//  Created by Eric on 2018/4/20.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "ELCollectionCell.h"

@implementation ELCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = UIColor.clearColor;
    return self;
}

- (void)pathMoveToPoint:(CGPoint *)point path:(CGMutablePathRef)p {
    CGPathMoveToPoint(p, 0, point->x, point->y);
}

- (void)pathAddLineToPoint:(CGPoint *)point path:(CGMutablePathRef)p {
    CGPathAddLineToPoint(p, 0, point->x, point->y);
}

- (CGRect)getRectWithCenter:(CGPoint *)p unitSize:(CGFloat)unit {
    return CGRectMake(p->x-unit/2, p->y-unit/2, unit, unit);
}

@end
