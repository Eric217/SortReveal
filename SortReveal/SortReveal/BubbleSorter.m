//
//  BubbleSorter.m
//  SortReveal
//
//  Created by Eric on 2018/4/18.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "Sorters.h"



@implementation BubbleSorter

- (NSArray<NSString *> *)nextTurn:(BOOL *)finished {
    
    if (dataArr.count == 2) {
        if ([self compare_a:0 b:1]) {
            [self swap_a:0 b:1];
        }
        *finished = 1;
        return [[NSArray alloc] initWithArray:dataArr copyItems:1];
    }
   
    int i = self.currentI, j = self.currentJ;
    if (i == 1) {
        return 0;
    }
    if (j == i - 2) {
        self.currentJ = 0;
        --self.currentI;
        if (self.currentI == 1) {
            return 0;
        }
    } else {
        ++self.currentJ;
    }
    
    j = self.currentJ;

    if (self.currentI == 2 && j == 0) {
        *finished = 1;
    }
    
    if ([self compare_a:j b:j+1]) {
        [self swap_a:j b:j+1];
    }
 
    return [[NSArray alloc] initWithArray:dataArr copyItems:1];
}

- (NSArray<NSString *> *)nextRow:(BOOL *)finished {
    return 0;
}

- (NSArray<NSString *> *)lastTurn:(BOOL *)finished {
    
    return 0;
}
 
- (NSArray<NSString *> *)lastRow:(BOOL *)finished {
    return 0;
}

- (void)initializeWithArray:(NSMutableArray *)array order:(SortOrder)order {
    self.sortOrder = order;
    dataArr = [[NSMutableArray alloc] initWithArray:array copyItems:1];
    self.currentI = (int)(array.count);
    self.currentJ = 0;
}


@end

