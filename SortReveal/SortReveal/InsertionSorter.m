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

@property (assign) bool willSwap;

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
@implementation InsertionSorter

- (void)move_a:(int)a to:(int)idx {
    
}

- (NSDictionary *)nextTurn:(BOOL *)finished {
    int i = self.currentI, j = self.currentJ; //1
    
    _willSwap = [self compareAtIndex_a:i b:j]; //返回1要交换
    if (!_willSwap) {
        [self swap_a:j+1 b:i];
        self.currentJ++;
        self.currentI++;
        //return
    } else {
        self.currentJ--;
        if (self.currentJ < 0) {
            [self move_a:i to:0];
            //sawp. ok.
        } else {
            //return
        }
    }
 
    
    
    
    return 0;
}

- (void)initializeWithArray:(NSMutableArray *)array order:(SortOrder)order {
    [super initializeWithArray:array order:order];
    self.currentI = 1;
    self.currentJ = 0; // = i - 1
}

@end

