//
//  ELSortUnitCollectionCell.m
//  SortReveal
//
//  Created by Eric on 2018/4/17.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "ELCollectionCell.h"
#import "Common.h"

@interface ELLinearUnitCell ()

@property (nonatomic, copy) NSArray *dataArr;
@property (nonatomic, copy) NSArray<NSString *> *posiArr;
@property (nonatomic, copy) NSArray *titlArr;
@property (nonatomic, copy) NSArray *coloArr;

@end

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
    
    _dataArr = [self.dataDict valueForKey:kDataArr];
    _posiArr = [self.dataDict valueForKey:kPositionArr];
    _titlArr = [self.dataDict valueForKey:kTitleArr];
    _coloArr = [self.dataDict valueForKey:kColorArr];
    
    CGFloat h = self.bounds.size.height;
    CGFloat w = self.bounds.size.width;
    CGFloat hBlow = h*0.4, hTextAbove = h*0.75;
    int arrSize = (int)self.dataArr.count;
    CGFloat offset = w/2 - arrSize * hBlow/2;
    offset = offset < 0 ? 0 : offset;
    CGFloat unitLength = (w-offset*2)/arrSize;
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
    textStyle.alignment = NSTextAlignmentCenter;//水平居中
    
    NSMutableDictionary *attr =  [@{NSFontAttributeName: [UIFont systemFontOfSize:30], NSParagraphStyleAttributeName: textStyle} mutableCopy];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    //左
    CGPathMoveToPoint(path, 0, offset, 0);
    CGPathAddLineToPoint(path, 0, offset, hBlow);
    //下
    CGPathMoveToPoint(path, 0, offset, hBlow);
    CGPathAddLineToPoint(path, 0, w-offset, hBlow);
    //上
    CGPathMoveToPoint(path, 0, offset, 0);
    CGPathAddLineToPoint(path, 0, w-offset, 0);

    
    for (int i = 0; i < arrSize; i++) {
        CGRect r = CGRectMake(offset+i*unitLength, 3, unitLength, hBlow);//3是文字偏移量
        CGPathMoveToPoint(path, 0, unitLength+r.origin.x, 0);
        CGPathAddLineToPoint(path, 0, unitLength+r.origin.x, hBlow);
        [self.dataArr[i] drawInRect:r withAttributes:attr];
    }
    
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    
    UIImage *upArrow = [UIImage imageNamed:@"upArrow"];
    int titleCount = (int)(self.titlArr.count);
    int repeati = -1, repeatj = -1; //这是在posiArr里的下标，其pos一样，为posiArr[i]
    bool hasRepeat = [self repeatIdx:&repeati idx:&repeatj];
    if (hasRepeat) {
        int r_idx = _posiArr[repeati].intValue;
        
        CGRect r = CGRectMake(offset+r_idx*unitLength, hTextAbove, unitLength/2, h-hTextAbove);
        [_titlArr[repeati] drawInRect:r withAttributes:attr];
        r.origin.x += unitLength/2;
        [_titlArr[repeatj] drawInRect:r withAttributes:attr];

        r.origin.y = hBlow;
        r.size.height = hTextAbove-hBlow;

        [upArrow drawInRect:CGRectInset(r, 2, 10)];
        r.origin.x -= 0.5*unitLength;
        [upArrow drawInRect:CGRectInset(r, 2, 10)];
      
    }
        
    CGRect r = CGRectMake(0, 0, unitLength, 0);
    for (int i = 0; i < titleCount; i++) {
        NSString * ps = _posiArr[i];
        int p = ps.intValue;
        if (p == repeati || p == repeatj) {
            continue;
        }
        //每个p是有字的位置，其字为title[i]
        r.origin.x = offset + p*(unitLength);
        r.origin.y = hTextAbove;
        r.size.height = h-hTextAbove;
        [_titlArr[i] drawInRect:r withAttributes:attr];
        r.origin.y = hBlow;
        r.size.height = hTextAbove-hBlow;
        [upArrow drawInRect:CGRectInset(r, 8, 0)];
        
    }
    
    
    CGContextSetLineWidth(ctx, 2);
    CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor.CGColor);
    CGContextAddPath(ctx, path);
    CGContextStrokePath(ctx);
  
}

- (bool)repeatIdx:(int *)m idx:(int *)n {
    int len = (int)(self.posiArr.count);
    for (int i = 0; i < len; i++) {
        for (int j = i+1; j < len; j++) {
            if ([_posiArr[i] isEqualToString:_posiArr[j]]) {
                *m = i;
                *n = j;
                return 1;
            }
        }
    }
    return 0;
}

@end
