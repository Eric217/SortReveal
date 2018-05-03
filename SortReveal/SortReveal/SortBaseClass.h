//
//  BubbleSorter.h
//  SortReveal
//
//  Created by Eric on 2018/4/18.
//  Copyright © 2018 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SorterProtocol.h"

///实现Sorter协议、Comparator协议，有各种顺序比较的功能
///内部一个历史记录数组，数组内容是什么根据子类确定。
@interface SortBaseClass : NSObject <Sorter, Comparator> {
    
@public
    NSMutableArray *historyArr;
    NSMutableArray<NSString *> *dataArr;
    
}

@property (assign) SortOrder sortOrder;

@end







