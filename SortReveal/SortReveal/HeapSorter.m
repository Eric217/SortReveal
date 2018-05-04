//
//  Sort.m
//  SortReveal
//
//  Created by Eric on 2018/4/16.
//  Copyright © 2018 Eric. All rights reserved.
//
 
#import "HeapSorter.h"
//#import "Heap.hpp"

@interface HeapSorter ()

//@property (nonatomic, assign) Heap<NSString *> heap;

@end

@implementation HeapSorter

- (NSDictionary *)nextTurn:(BOOL *)finished {
    
    
    return 0;
}

- (NSDictionary *)initializeHeap {
    
    int currentSize = (int)dataArr.count;
    for (int i = currentSize/2; i > 0; i--) {
        NSString *t = dataArr[i-1];
        int c_idx = 2*i-1;
        while (c_idx+1 <= currentSize) {
            if (c_idx+1 < currentSize && [self compareAtIndex_a:c_idx+1 b:c_idx]) //一个符号 <
                c_idx++;
            if ([self compareElement_a:t b:dataArr[c_idx]]) // >=
                break;

            dataArr[(c_idx-1)/2] = dataArr[c_idx];
            c_idx = c_idx*2+1;
        }
        int a = (c_idx+1)/2-1;
        dataArr[a] = t;
    }
    return @{kDataArr: dataArr};
}

- (void)initializeWithArray:(NSMutableArray *)array order:(SortOrder)order {
    [super initializeWithArray:array order:order];
    
    
}



@end


