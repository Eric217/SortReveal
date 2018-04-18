//
//  BubbleSorter.h
//  SortReveal
//
//  Created by Eric on 2018/4/18.
//  Copyright © 2018 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"


@interface SortBaseClass : NSObject <Sorter>

@property (assign) SortOrder sortOrder;

- (void)swap_i:(int)i j:(int)j;


@end



@interface LinearSort : SortBaseClass

@property (nonatomic, copy) NSArray<NSString *> *originArr;
@property (assign) int currentI;
@property (assign) int currentJ;
@end




