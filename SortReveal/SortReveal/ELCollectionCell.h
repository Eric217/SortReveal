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
#import "Protocols.h"

@interface ELCollectionViewCell: UICollectionViewCell

@property (nonatomic, copy) NSArray<NSString *> *dataArr;

@end

@interface ELTreeUnitCell : ELCollectionViewCell

@end



@interface ELLinearUnitCell : ELCollectionViewCell

@end
#endif /* ELCollectionVCell_h */
