//
//  ELRepeatLinearCell.m
//  SortReveal
//
//  Created by Eric on 2018/4/26.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "ELRepeatLinearCell.h"

@implementation ELRepeatLinearCell

- (bool)repeatIdx:(int *)m idx:(int *)n {
    int len = (int)(self.posiArr.count);
    for (int i = 0; i < len; i++) {
        for (int j = i+1; j < len; j++) {
            if ([self.posiArr[i] isEqualToString:self.posiArr[j]]) {
                *m = i;
                *n = j;
                return 1;
            }
        }
    }
    return 0;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
 
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
    int repeati = -1, repeatj = -1; //这是在posiArr里的下标，其pos一样，为posiArr[i]
    bool hasRepeat = [self repeatIdx:&repeati idx:&repeatj];
    
    if (hasRepeat) {
        int r_idx = self.posiArr[repeati].intValue;
        attr[NSFontAttributeName] = [UIFont systemFontOfSize:15];
        
        CGRect r = CGRectMake(offset+r_idx*unitLength, hTextAbove, unitLength/2, h-hTextAbove);
        [self.titlArr[repeati] drawInRect:r withAttributes:attr];
        r.origin.x += unitLength/2;
        [self.titlArr[repeatj] drawInRect:r withAttributes:attr];
        
        r.origin.y = hBlow;
        r.size.height = hTextAbove-hBlow;
        
        [upArrow drawInRect:CGRectInset(r, 2, 6)];
        r.origin.x -= 0.5*unitLength;
        [upArrow drawInRect:CGRectInset(r, 2, 6)];
        
    }
    
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    CGRect r = CGRectMake(0, 0, unitLength, 0);
    
    for (int i = 0; i < titleCount; i++) {
        NSString * ps = self.posiArr[i];
        int p = ps.intValue;
        if (p == repeati || p == repeatj) {
            continue;
        }
        //每个p是有字的位置，其字为title[i]
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
