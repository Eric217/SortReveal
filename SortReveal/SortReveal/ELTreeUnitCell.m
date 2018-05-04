//
//  ELTreeUnitCell.m
//  SortReveal
//
//  Created by Eric on 2018/4/17.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "ELTreeUnitCell.h"
//#import "HuffmanTree.hpp"

#define UnitSize 44
#define SepaWidth 0.5*UnitSize


@interface ELTreeUnitCell ()
@property (assign) int height;


@end


@implementation ELTreeUnitCell

- (void)setDataDict:(NSDictionary *)dataDict {
    super.dataDict = dataDict;
    
    _treeArray = [dataDict valueForKey:kDataArr];
    _sortedArray = [dataDict valueForKey:kTitleArr];
    int c = (int)_treeArray.count;
    _height = (int)(log2(c)+1);
    
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat h = self.bounds.size.height;
    CGFloat w = self.bounds.size.width;
    CGFloat lineWidth = 2;

    
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
    textStyle.alignment = NSTextAlignmentCenter;//水平居中
    NSMutableDictionary *attr =  [@{NSFontAttributeName: [UIFont systemFontOfSize:18], NSParagraphStyleAttributeName: textStyle} mutableCopy];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    
    
    
    
    
    
    
    
    
    
    
    CGContextSetLineWidth(ctx, lineWidth);
    CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor.CGColor);
    CGContextAddPath(ctx, path);
    CGContextStrokePath(ctx);
}


///need free points
- (CGPoint *)getLocations {
    int arrSize = pow(2, _height)-1;
    CGPoint *points = (CGPoint *)malloc(arrSize*sizeof(CGPoint));
    
    //最底层单独确定位置
    int s = pow(2, _height-1) - 1;
    CGFloat bottom = 5;
    CGFloat left = 5;
    CGFloat angle = M_PI/3;
    
    for (int i = s; i <= 2*s; i++) {
        points[i] = CGPointMake(left+0.5*UnitSize+(i-s)*(UnitSize+SepaWidth), UnitSize*0.5+bottom);
    }
    
    //其余层靠子树确定位置
    for (int i = _height-2; i >= 0; i--) {
        int s = pow(2, i) - 1;
        for (int j = s; j <= 2*s; j++) {
            int point1Idx = 2*j+1;
            CGFloat x1 = points[point1Idx].x;
            CGFloat lastLevelBian = points[point1Idx+1].x - x1;
            CGFloat x2 = x1 + lastLevelBian/2; //X
            CGFloat y2;
            if (j == s) {
                y2 = points[point1Idx].y + lastLevelBian/2*tan(angle);
                angle -= [self angleReducementAtLevel:i];
            } else
                y2 = points[j-1].y;
            points[j] = CGPointMake(x2, y2);
        }
        
    }
    
    [self convertOrdinate:points length:arrSize];
    
    return points;
}

///level: _height-2 -> 0
- (CGFloat)angleReducementAtLevel:(int)level {
    return 0.05;
}

- (void)convertOrdinate:(CGPoint *)points length:(int)size{
    for (int i = 0; i < size; i++) {
        points[i].y = self.bounds.size.height - points[i].y;
    }
}

@end
