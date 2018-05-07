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
    
    ///历史数据，每个子类自行处理
    NSMutableArray *historyArr;
    ///输入框内容的数组
    NSMutableArray<NSString *> *dataArr;
    
}
 
@property (assign) SortOrder sortOrder;

@end







