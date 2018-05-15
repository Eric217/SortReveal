//
//  SorterProtocol.h
//  SortReveal
//
//  Created by Eric on 2018/4/25.
//  Copyright © 2018 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"

///排序类 必须遵循的接口
@protocol Sorter <NSObject>
@optional

- (void)initializeWithArray:(NSMutableArray *)array order:(SortOrder)order;

- (void)lastStep;

- (NSDictionary *)nextTurn:(BOOL *)finished;
- (NSDictionary *)nextRow:(BOOL *)finished;
- (NSDictionary *)initialSortData;
//返回的字典中 含有1. 数组kDataArr 2. 箭头信息 3. 颜色信息kColorArr

@end

@protocol Comparator <NSObject>

@optional
- (void)swap_a:(int)i b:(int)j;
- (bool)compareAtIndex_a:(int)a b:(int)b;
- (bool)compareElement_a:(NSString *)x b:(NSString *)y;

- (bool)compareByNumber:(double)a with:(double)b order:(bool)lower;
- (bool)compareByChar:(NSString *)a with:(NSString *)b order:(bool)lower;
- (bool)compareByDict:(NSString *)a with:(NSString *)b order:(bool)lower;
- (bool)compareByAutomatic:(NSString *)a with:(NSString *)b order:(bool)lower;

@end


