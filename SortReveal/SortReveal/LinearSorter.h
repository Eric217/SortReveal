//
//  LinearSorter+a.h
//  SortReveal
//
//  Created by Eric on 2018/4/25.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "SortBaseClass.h"

#define kHistoryPosition @"grsaereshtbed"

///线性（底层为数组）排序的基类，继承自Base，内部有一个数组
@interface LinearSorter : SortBaseClass {
    
@public
    NSMutableArray<NSString *> *dataArr;
    
}

@property (assign) int currentI;
@property (assign) int currentJ;
 
@end
