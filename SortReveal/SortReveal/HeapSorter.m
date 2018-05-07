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

@property (nonatomic, copy) NSMutableArray<NSString *> *sortedArr;
@property (nonatomic, assign) int currentNode;

@end

@implementation HeapSorter

- (NSDictionary *)nextTurn:(BOOL *)finished {
    
    NSMutableArray *toBeSavedArray = [[NSMutableArray alloc] initWithArray:dataArr copyItems:1];
    if (_currentNode == -1) { //需要pop
        NSString *first = dataArr.firstObject;
        NSString *last  = dataArr.lastObject;
        [dataArr removeLastObject];
        [_sortedArr insertObject:first atIndex:0];
        NSUInteger count = dataArr.count;
        if (count == 0) {
            *finished = 1;
        } else {
            dataArr[0] = last;
            _currentNode = count == 1 ? -1 : 0;
        }
    } else { //到了node处，开始往下交换
        int nodeCount = (int)dataArr.count;
        int child = _currentNode*2+1;
    
        if (child+1 < nodeCount && [self compareAtIndex_a:child+1 b:child])
            child++;
        if ([self compareAtIndex_a:child b:_currentNode]) { //need swap
            [self swap_a:child b:_currentNode];
            if (child*2+1 > nodeCount-1) { //没有子孩子
                _currentNode = -1;
            } else
                _currentNode = child;
        } else {
            _currentNode = -1;
            if (!(*finished) && [UserDefault boolForKey:kSkipNullStep]) {
                return [self nextTurn:finished];
            }
        }
    }
    
    [historyArr addObject:@{kDataArr: toBeSavedArray, kHistoryPosition: NSStringFromCGPoint(CGPointMake(_currentNode, 0))}];
    
    if (*finished) {//8
        return @{kTitleArr: _sortedArr.copy};
    } else {//9
        //TODO: - color
        
    
        
        return @{kDataArr: dataArr.copy, kTitleArr: _sortedArr.copy};
    }
    
}


- (NSDictionary *)initializeHeap {
    
    int currentSize = (int)dataArr.count;
    for (int i = currentSize/2; i > 0; i--) {
        NSString *saved = dataArr[i-1];
        int child = 2*i-1;
        while (child+1 <= currentSize) {
            if (child+1 < currentSize && [self compareAtIndex_a:child+1 b:child])
                child++;
            if ([self compareElement_a:saved b:dataArr[child]])
                break;
            dataArr[(child-1)/2] = dataArr[child];
            child = child*2+1;
        }
        int t = (child+1)/2-1;
        dataArr[t] = saved;
    }
    _currentNode = -1;
    _sortedArr = [[NSMutableArray alloc] init];
    return @{kDataArr: dataArr.copy};
}

//- (void)initializeWithArray:(NSMutableArray *)array order:(SortOrder)order {
//    [super initializeWithArray:array order:order];
//}


@end


