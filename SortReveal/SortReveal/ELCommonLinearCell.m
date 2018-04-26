//
//  ELCommonLinearCell.m
//  SortReveal
//
//  Created by Eric on 2018/4/26.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "ELCommonLinearCell.h"

@implementation ELCommonLinearCell


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];//bounds现在有值
 
    CGFloat h = self.bounds.size.height;
    CGFloat w = self.bounds.size.width;
    CGFloat hBlow = h*0.4, hTextAbove = h*0.75;
    int arrSize = (int)self.dataArr.count;
    CGFloat offset = w/2 - arrSize * hBlow/2;
    offset = offset < 0 ? 0 : offset;
    CGFloat unitLength = (w-offset*2)/arrSize;
    CGFloat lineWidth = 2;
    
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
    textStyle.alignment = NSTextAlignmentCenter;//水平居中
    
    NSMutableDictionary *attr =  [@{NSFontAttributeName: [UIFont systemFontOfSize:27], NSParagraphStyleAttributeName: textStyle} mutableCopy];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    //左
    CGPathMoveToPoint(path, 0, offset, 0);
    CGPathAddLineToPoint(path, 0, offset, hBlow);
    //下
    CGPathMoveToPoint(path, 0, offset-lineWidth/2, hBlow);
    CGPathAddLineToPoint(path, 0, w-offset+lineWidth/2, hBlow);
    //上
    CGPathMoveToPoint(path, 0, offset, lineWidth/2);
    CGPathAddLineToPoint(path, 0, w-offset, lineWidth/2);
    
    
    for (int i = 0; i < arrSize; i++) {
        CGRect r = CGRectMake(offset+i*unitLength, 2.5, unitLength, hBlow);//2.5是文字偏移量
        CGPathMoveToPoint(path, 0, unitLength+r.origin.x, 0);
        CGPathAddLineToPoint(path, 0, unitLength+r.origin.x, hBlow);
        [self.dataArr[i] drawInRect:r withAttributes:attr];
    }
    
    
    UIImage *upArrow = [UIImage imageNamed:@"upArrow"];
    int titleCount = (int)(self.titlArr.count);
 
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    CGRect r = CGRectMake(0, 0, unitLength, 0);
    
    for (int i = 0; i < titleCount; i++) {
        int p = ((NSString *)(self.posiArr[i])).intValue;
        r.origin.x = offset + p*(unitLength);
        r.origin.y = hTextAbove;
        r.size.height = h-hTextAbove;
        [self.titlArr[i] drawInRect:r withAttributes:attr];
        r.origin.y = hBlow;
        r.size.height = hTextAbove-hBlow;
        [upArrow drawInRect:CGRectInset(r, 10, 6)];
        
    }
    
    CGContextSetLineWidth(ctx, lineWidth);
    CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor.CGColor);
    CGContextAddPath(ctx, path);
    CGContextStrokePath(ctx);
    
}


@end
