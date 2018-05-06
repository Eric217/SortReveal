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

- (CGRect)getRectWithCenter:(CGPoint *)p {
    return CGRectMake(p->x-UnitSize/2, p->y-UnitSize/2, UnitSize, UnitSize);
}

- (void)convertOrdinate:(CGPoint *)points length:(int)size{
    for (int i = 0; i < size; i++) {
        points[i].y = self.bounds.size.height - points[i].y;
    }
}

@end
