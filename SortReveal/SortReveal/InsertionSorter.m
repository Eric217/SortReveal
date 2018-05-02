//
//  InsertionSorter.m
//  SortReveal
//
//  Created by Eric on 2018/4/18.
//  Copyright © 2018 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinearSubSorters.h"
@interface InsertionSorter ()

//@property (assign) bool willSwap;
@property (nonatomic, copy) NSMutableArray *turnArray;
@end
/*
template <typename T>
void insertForSort(T * arr, const T t, int length) {
    int i;
    for (i = length - 1; i >= 0 && arr[i] < t; i--)
        arr[i+1] = arr[i];
    arr[i+1] = t;
}
template <typename T>
void insertionSort(T * arr, int length) {
    for (int i = 1; i < length; i++)
        insertForSort(arr, arr[i], i);
}
template <typename T>
void insertionSort2(T * arr, int length) {
    for (int i = 1; i < length; i++) {
        int j;
        T t = arr[i];
        for (j = i - 1; j >= 0 && arr[j] < t; j--)
            arr[j+1] = arr[j];
        arr[j+1] = t;
    }
}
 */

///对于插入排序，currentI只是象征性的，currentJ+1才是与J比较的对象。
@implementation InsertionSorter


- (NSDictionary *)nextTurn:(BOOL *)finished {
    int i = self.currentI, j = self.currentJ; //1
    int len = (int)(dataArr.count);
    NSMutableArray *toBeSavedArray = [[NSMutableArray alloc] initWithArray:dataArr copyItems:1];

    if (len == 2) {
        if ([self compareAtIndex_a:0 b:1]) {
            [self swap_a:0 b:1];
        }
        *finished = 1;        
    } else {

        bool _willSwap = [self compareAtIndex_a:j b:j+1]; //返回1要交换
        if (!_willSwap) {
            self.currentI++;
            NSArray *turnArrayUnit = [[NSArray alloc] initWithArray:toBeSavedArray copyItems:1];
            [_turnArray addObject:turnArrayUnit];
            self.currentJ = self.currentI-1;
            if (self.currentI == len) {
                *finished = 1;
            }
        } else {
            [self swap_a:j b:j+1];
            self.currentJ--;
            
            if (self.currentJ < 0) {
                self.currentI++;
                NSArray *turnArrayUnit = [[NSArray alloc] initWithArray:dataArr copyItems:1];
                [_turnArray addObject:turnArrayUnit];
                self.currentJ = self.currentI-1;
                if (self.currentI == len) {
                    *finished = 1;
                }
                
            }
            
        }
    }
  
    [historyArr addObject:@{kDataArr: toBeSavedArray, kHistoryPosition: NSStringFromCGPoint(CGPointMake(i, j))}]; //10
    
    if (*finished) {//8
        return @{kDataArr: dataArr.copy};
    } else {//9
        int t = self.currentI;
        NSMutableArray *data = [NSMutableArray arrayWithCapacity: t];
        for (int k = 0; k < t; k++) {
            [data addObject:_turnArray[_turnArray.count-1][k]];
        }
        NSString *num1 = [NSString stringWithFormat:@"%d", self.currentJ];
        //TODO: - color
        NSString *comming = historyArr[0][kDataArr][t];
        return @{kDataArr: data, kPositionArr: @[num1], kTitleArr: @[@"j"], kCommingText: comming};
    }
    return 0;
}

- (void)lastStep {
    NSDictionary *d = [historyArr lastObject];
    CGPoint p = CGPointFromString(d[kHistoryPosition]);
    dataArr = d[kDataArr];
    [historyArr removeLastObject];
 
    if (self.currentI != p.x) {
        [_turnArray removeLastObject];
    }
    self.currentJ = p.y;
    self.currentI = p.x;
    
}


- (void)initializeWithArray:(NSMutableArray *)array order:(SortOrder)order {
    self.sortOrder = order;
    dataArr = [[NSMutableArray alloc] initWithArray:array copyItems:1];
    _turnArray = [[NSMutableArray alloc] init];
    self.currentI = 1;
    self.currentJ = 0; // = i - 1
}

@end

