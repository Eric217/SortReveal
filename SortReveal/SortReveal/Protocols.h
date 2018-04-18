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

- (NSArray<NSString *> *)nextTurn:(BOOL *)finished;
- (NSArray<NSString *> *)nextRow:(BOOL *)finished;
- (NSArray<NSString *> *)lastRow:(BOOL *)finished;
- (NSArray<NSString *> *)lastTurn:(BOOL *)finished;

@end

@protocol Comparable <NSObject>

@optional
- (void)swap_a:(int)i b:(int)j;
- (bool)compare_a:(int)a b:(int)b;

@end


@protocol SimpleTransfer <NSObject>

- (void)transferData:(id)data;

@end



