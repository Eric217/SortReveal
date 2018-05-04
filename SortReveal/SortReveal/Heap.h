//
//  Heap.h
//  SortReveal
//
//  Created by Eric on 2018/5/3.
//  Copyright © 2018 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SorterProtocol.h"

@interface Heap : NSObject

@property (weak) id <Comparator> comparator;

+ (Heap *)initializeWithArr:(NSMutableArray *)array size:(int)arrSize;
- (void)updateMaxSize:(int)size;


@end

