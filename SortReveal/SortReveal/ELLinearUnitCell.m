//
//  ELSortUnitCollectionCell.m
//  SortReveal
//
//  Created by Eric on 2018/4/17.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "ELCollectionCell.h"

@implementation ELLinearUnitCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];//bounds现在有值
    
    CGFloat h = self.bounds.size.height;
    CGFloat w = self.bounds.size.width;
    CGFloat hBlow = h*0.55, hAbove = h*0.45;
    int arrSize = (int)self.dataArr.count;
    CGFloat offset = w/2 - arrSize * hBlow/2;
    offset = offset < 0 ? 0 : offset;
    CGFloat unitLength = (w-offset*2)/arrSize;
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
    textStyle.alignment = NSTextAlignmentCenter;//水平居中
    
    NSDictionary *attr =  @{NSFontAttributeName: [UIFont systemFontOfSize:30], NSParagraphStyleAttributeName: textStyle};
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, 0, offset, hAbove);
    CGPathAddLineToPoint(path, 0, offset, h);
    CGPathAddLineToPoint(path, 0, w-offset, h+1);

    for (int i = 0; i < arrSize; i++) {
        CGRect r = CGRectMake(offset+i*unitLength, hAbove, unitLength, hBlow);
        CGPathAddRect(path, 0, r);
        [self.dataArr[i] drawInRect:r withAttributes:attr];
    }

    CGContextSetLineWidth(ctx, 2);
    CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor.CGColor);
    CGContextAddPath(ctx, path);
    CGContextStrokePath(ctx);
  
}

@end
