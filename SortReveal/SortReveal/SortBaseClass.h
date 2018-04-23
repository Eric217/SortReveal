//
//  BubbleSorter.h
//  SortReveal
//
//  Created by Eric on 2018/4/18.
//  Copyright © 2018 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"

///直接实现Sorter协议，含有sort order 这一通用值
@interface SortBaseClass : NSObject <Sorter, Comparable> {
@public
    NSMutableArray *historyArr;
}

@property (assign) SortOrder sortOrder;

@end


///线性（底层为数组）排序的基类，继承自Base，内部有一个数组
@interface LinearSorter : SortBaseClass {
    
@public
    NSMutableArray<NSString *> *dataArr;
    
}

@property (assign) int currentI;
@property (assign) int currentJ;


@end




