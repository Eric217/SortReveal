//
//  ELTreeUnitCell.m
//  SortReveal
//
//  Created by Eric on 2018/4/17.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "ELTreeUnitCell.h"
 

@interface ELTreeUnitCell ()
@property (assign) int height;

@end


@implementation ELTreeUnitCell

- (void)setDataDict:(NSDictionary *)dataDict {
    super.dataDict = dataDict;
    
    _treeArray = [dataDict valueForKey:kDataArr];
    _sortedArray = [dataDict valueForKey:kTitleArr];
    _height = [Config getTreeHeight:_treeArray.count];
    
}

- (void)convertOrdinate:(CGPoint *)points length:(int)size {
    for (int i = 0; i < size; i++) {
        points[i].y = self.bounds.size.height - points[i].y;
    }
}

//树枝有多长由 SepaWidth Angle 共同决定
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //--------------SPECIFICATION-----------------
    int nodes = (int)_treeArray.count;
    CGPoint * points = [Config getLocaWithHeight:_height startAngle:M_PI/3 angleReducer:^(int level, CGFloat * angle) {
        *angle -=  (M_PI*7/30.0)/(self.height-0.65);
    }];
    [self convertOrdinate:points length:pow(2, _height)-1];
    
    //-------------TEXT ATTRIBUTES---------------
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
    textStyle.alignment = NSTextAlignmentCenter;//水平居中,但是竖直不居中...
    NSMutableDictionary *attr =  [@{NSFontAttributeName: [UIFont systemFontOfSize:24], NSParagraphStyleAttributeName: textStyle} mutableCopy];
    
    //----------------DRAW LINE------------------
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    for (int i = nodes-1; i > 0; i--) { //n个节点有n-1条线
        [self pathMoveToPoint:points+i path:path];
        [self pathAddLineToPoint:points+(i-1)/2 path:path];
    }
    CGContextSetLineWidth(ctx, LineWidth);
    CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor.CGColor);
    CGContextAddPath(ctx, path);
    CGContextStrokePath(ctx);
    
    //----------------FILL ARC-------------------
    CGContextSetFillColorWithColor(ctx, UIColor.whiteColor.CGColor);
    for (int i = 0; i < nodes; i++)
        CGContextFillEllipseInRect(ctx, [self getRectWithCenter:points+i]);
    
    //----------------DRAW ARC-------------------
    for (int i = 0; i < nodes; i++) {
        CGRect r = [self getRectWithCenter:points+i];
        [_treeArray[i] drawInRect:CGRectInset(r, 0, 6) withAttributes:attr];
        CGContextStrokeEllipseInRect(ctx, r);
    }
    //-------
    
    CGFloat h = self.bounds.size.height;
    CGFloat w = self.bounds.size.width;

    
    
    free(points);
}




@end
