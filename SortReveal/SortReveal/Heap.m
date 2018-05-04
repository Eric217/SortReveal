//
//  Heap.m
//  SortReveal
//
//  Created by Eric on 2018/5/3.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "Heap.h"
#import "SortBaseClass.h"

@interface Heap ()

@property (nonatomic, copy) NSMutableArray *elements;
@property (assign) int currentSize;
@property (assign) int maxSize;

@end

@implementation Heap

- (void)updateMaxSize:(int)size {
    _maxSize = size;
}

+ (Heap *)initializeWithArr:(NSMutableArray *)array size:(int)arrSize comparator:(id <Comparator>)cmpt {
    Heap *h = [[Heap alloc] init];
    h.elements = array; //MARK: - STRONG ref,一会直接交换原数组内容
    h.maxSize = h.currentSize = arrSize;
    h.comparator = cmpt;
    return h;
}

- (void)constructHeap {
    for (int i = _currentSize/2; i > 0; i--) {
        id t = _elements[i-1];
        int c_idx = 2*i-1;
        while (c_idx+1 <= _currentSize) {
            if (c_idx+1 < _currentSize && [_comparator compareAtIndex_a:c_idx+1 b:c_idx]) //一个符号 <
                c_idx++;
            if (t < _elements[c_idx]) // >=
                break;
            //arr[i-1] = arr[c_idx];
            c_idx = c_idx*2+1;
        }
        int a = (c_idx+1)/2-1;
        
        SortBaseClass *sorter = (SortBaseClass *)_comparator;
        SortBaseClass *s = [[SortBaseClass alloc] init];
        sorter.dataArr
        arr[a] = t;
        
    }
    
}


@end
