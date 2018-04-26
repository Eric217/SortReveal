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

//BASE
@interface ELCollectionViewCell: UICollectionViewCell

@property (nonatomic, copy) NSDictionary *dataDict;

@end
 
@interface ELGroupedUnitCell : ELCollectionViewCell
@end

 
#endif /* ELCollectionVCell_h */
