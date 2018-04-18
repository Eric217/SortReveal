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
- (void)initializeWithArray:(NSArray *)array order:(SortOrder)order;

- (NSArray<NSString *> *)nextTurn:(int)i step:(int)j;

- (NSArray<NSString *> *)lastTurn:(int)i step:(int)j;

@end


@protocol SimpleTransfer <NSObject>

- (void)transferData:(id)data;

@end



