//
//  Sort.m
//  SortReveal
//
//  Created by Eric on 2018/4/16.
//  Copyright © 2018 Eric. All rights reserved.
//
 
#import "HeapSorter.h"
#import "Heap.hpp"

@interface HeapSorter ()

@property (nonatomic, assign) Heap<NSString *> heap;

@end

@implementation HeapSorter

- (NSDictionary *)nextTurn:(BOOL *)finished {
    
    
    return 0;
}

- (void)initializeWithArray:(NSMutableArray *)array order:(SortOrder)order {
    self.sortOrder = order;
    dataArr = [[NSMutableArray alloc] initWithArray:array copyItems:1];
    
    
    
}



@end


