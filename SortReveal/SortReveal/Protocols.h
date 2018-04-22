//
//  Protocols.h
//  SortReveal
//
//  Created by Eric on 2018/4/16.
//  Copyright © 2018 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"

///想排序 必须遵循的接口
@protocol Sorter <NSObject>

@optional
- (void)initializeWithArray:(NSMutableArray *)array order:(SortOrder)order;

///返回的字典中 含有1. 数组kDataArr 2. 箭头信息kArrowArr 3. 颜色信息kColorArr
- (NSDictionary *)nextTurn:(BOOL *)finished;
- (NSDictionary *)nextRow:(BOOL *)finished;

- (void)lastStep;

@end

@protocol Comparable <NSObject>

@optional
- (void)swap_a:(int)i b:(int)j;
- (bool)compare_a:(int)a b:(int)b;

@end


@protocol SimpleTransfer <NSObject>

- (void)transferData:(id)data;

@end



