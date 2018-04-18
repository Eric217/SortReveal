//
//  BubbleSorter.h
//  SortReveal
//
//  Created by Eric on 2018/4/18.
//  Copyright © 2018 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

///想排序 必须遵循的接口
@protocol Sorter <NSObject>
@optional
- (void)initializeWithArray:(NSArray *)array order:(SortOrder)order;

- (NSArray<NSString *> *)next;

- (NSArray<NSString *> *)last;

@end



@interface SortBaseClass : NSObject <Sorter>
@property (assign) SortOrder sortOrder;
@end
@implementation SortBaseClass
@end

@interface LinearSort : SortBaseClass
@property (nonatomic, copy) NSArray<NSString *> *originArr;



@end
@implementation LinearSort
@end

@interface BubbleSorter : LinearSort

@end


