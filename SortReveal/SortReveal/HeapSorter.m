//
//  SortReveal
//
//  Created by Eric on 2018/4/16.
//  Copyright © 2018 Eric. All rights reserved.
//
 
#import "HeapSorter.h"

@interface HeapSorter ()

@property (nonatomic, copy) NSMutableArray<NSString *> *sortedArr;
@property (nonatomic, assign) int currentNode;
@property (nonatomic, assign) int lastNode;

@end

@implementation HeapSorter

- (NSDictionary *)nextTurn:(BOOL *)finished {
    
    NSMutableArray *toBeSavedArray = [[NSMutableArray alloc] initWithArray:dataArr];
    int currNode = _currentNode;
    
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
                _lastNode = currNode;
                return [self nextTurn:finished];
            }
        }
    }
    int temp = _lastNode == -2 ? currNode : _lastNode;
    _lastNode = -2;
    [historyArr addObject:@{kDataArr: toBeSavedArray, kHistoryPosition: NSStringFromCGPoint(CGPointMake(temp, 0))}];
    
    if (*finished) {//8
        return @{kTitleArr: _sortedArr.copy};
    } else {//9
        //TODO: - color
        return @{kDataArr: dataArr.copy, kTitleArr: _sortedArr.copy};
    }
}



- (NSDictionary *)nextRow:(BOOL *)finished {
    NSMutableArray *toBeSavedArray = [[NSMutableArray alloc] initWithArray:dataArr];
    int currNode = _currentNode;
    if (_currentNode != -1) {
        NSString *saved = dataArr[_currentNode];
        int child = 2*_currentNode+1;
        NSUInteger coun = dataArr.count;
        BOOL swapped = 0;
        while (child < coun) {
            if (child+1 < coun && [self compareAtIndex_a:child+1 b:child])
                child++;
            if ([self compareElement_a:saved b:dataArr[child]])
                break;
            swapped = 1;
            dataArr[(child-1)/2] = dataArr[child];
            child = child*2+1;
        }
        int t = (child+1)/2-1;
        dataArr[t] = saved;
        _currentNode = -1;
        if (!swapped && !(*finished) && [UserDefault boolForKey:kSkipNullStep]) {
            _lastNode = currNode;
            return [self nextRow:finished];
        }
    } else {
        NSString *first = dataArr.firstObject;
        NSString *last  = dataArr.lastObject;
        [dataArr removeLastObject];
        [_sortedArr insertObject:first atIndex:0];
        NSUInteger coun = dataArr.count;
        if (coun == 0) {
            *finished = 1;
        } else {
            dataArr[0] = last;
            NSString *saved = last;
            int child = 1;
            while (child < coun) {
                if (child+1 < coun && [self compareAtIndex_a:child+1 b:child])
                    child++;
                if ([self compareElement_a:saved b:dataArr[child]])
                    break;
                dataArr[(child-1)/2] = dataArr[child];
                child = child*2+1;
            }
            int t = (child+1)/2-1;
            dataArr[t] = saved;
        }
        
    }
    
    int temp = _lastNode == -2 ? currNode : _lastNode;
    _lastNode = -2;
    [historyArr addObject:@{kDataArr: toBeSavedArray, kHistoryPosition: NSStringFromCGPoint(CGPointMake(temp, 0))}];
    
    if (*finished) {
        return @{kTitleArr: _sortedArr.copy};
    } else {
        //TODO: - color
        return @{kDataArr: dataArr.copy, kTitleArr: _sortedArr.copy};
    }
   
}


- (void)lastStep {
    NSDictionary *d = [historyArr lastObject];
    NSUInteger originSize = ((NSArray *)(historyArr.firstObject[kDataArr])).count;
    _currentNode = CGPointFromString(d[kHistoryPosition]).x;
    dataArr = d[kDataArr];
    [historyArr removeLastObject];
    if (originSize - dataArr.count != _sortedArr.count) {
        [_sortedArr removeObjectAtIndex:0];
    }
 
}

- (NSDictionary *)initialSortData {
    int currentSize = (int)dataArr.count;

    if (currentSize == 1) {
        return @{kDataArr: dataArr.copy};
    }
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
    return @{kDataArr: dataArr.copy};
}

- (void)initializeWithArray:(NSMutableArray *)array order:(SortOrder)order {
    [super initializeWithArray:array order:order];
    _lastNode = -2;
    _currentNode = -1;
    _sortedArr = [[NSMutableArray alloc] init];
}


- (bool)compareElement_a:(NSString *)x b:(NSString *)y {
    bool b = [super compareElement_a:x b:y];
    if (!(self.sortOrder % 10)) {
        return [UserDefault boolForKey:kPreferMinHeap] ? !b : b;
    }
    return b;
}

@end


