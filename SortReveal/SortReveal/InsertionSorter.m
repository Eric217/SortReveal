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

- (void)move_a:(int)a to:(int)idx {
    
}

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
            self.currentJ = self.currentI-1;
            if (self.currentI == len) {
                *finished = 1;
            }
            
            
            
            
        } else {
            [self swap_a:j b:j+1];
            self.currentJ--;
            
            if (self.currentJ < 0) {
                self.currentI++;
                self.currentJ = self.currentI-1;
                if (self.currentI == len) {
                    *finished = 1;
                }
                
            }
            
        }
        
        
        
    }
    
    
    NSArray *data = [[NSArray alloc] initWithArray:dataArr copyItems:0]; //7
    [historyArr addObject:@{kDataArr: toBeSavedArray, kHistoryPosition: NSStringFromCGPoint(CGPointMake(i, j))}]; //10
    
    if (*finished) {//8
        return @{kDataArr: data};
    } else {//9
        //NSString *num0 = [NSString stringWithFormat:@"%d", self.currentI];
        NSString *num1 = [NSString stringWithFormat:@"%d", self.currentJ];
        //TODO: - color
        NSString *comming = historyArr[0][kDataArr][i];
        return @{kDataArr: data, kPositionArr: @[num1], kTitleArr: @[@"j"], kCommingText: comming};
    }
    return 0;
}

- (void)shouldReturnI:(int)i J:(int)j {
    
    
    
}


- (void)initializeWithArray:(NSMutableArray *)array order:(SortOrder)order {
    [super initializeWithArray:array order:order];
    self.currentI = 1;
    self.currentJ = 0; // = i - 1
}

@end

