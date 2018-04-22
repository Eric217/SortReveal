//
//  Sorters.h
//  SortReveal
//
//  Created by Eric on 2018/4/18.
//  Copyright © 2018 Eric. All rights reserved.
//

#ifndef Sorters_h
#define Sorters_h
#import "SortBaseClass.h"

@interface BubbleSorter : LinearSorter

@end


@interface InsertionSorter: LinearSorter

@end


@interface SelectionSorter: LinearSorter

@end


@interface HeapSorter: SortBaseClass

@end


#endif /* Sorters_h */
