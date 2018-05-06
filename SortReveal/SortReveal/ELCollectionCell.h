//
//  ELCollectionVCell.h
//  SortReveal
//
//  Created by Eric on 2018/4/17.
//  Copyright © 2018 Eric. All rights reserved.
//

#ifndef ELCollectionCell_h
#define ELCollectionCell_h

#import <UIKit/UIKit.h>
#import "Common.h"

@interface ELCollectionViewCell: UICollectionViewCell

@property (nonatomic, copy) NSDictionary *dataDict;


- (void)pathMoveToPoint:(CGPoint *)point path:(CGMutablePathRef)p;

- (void)pathAddLineToPoint:(CGPoint *)point path:(CGMutablePathRef)p;

- (void)convertOrdinate:(CGPoint *)points length:(int)size;

- (CGRect)getRectWithCenter:(CGPoint *)p;

@end
 
 
#endif /* ELCollectionVCell_h */
