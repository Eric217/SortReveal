//
//  BubbleSorter.m
//  SortReveal
//
//  Created by Eric on 2018/4/18.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "BubbleSorter.h"



@implementation BubbleSorter



- (void)bubbleSortOffSetI:(int)x J:(int)y {
    int len = (int)(self.originArr.count);
    for (int i = x; i < len; i++) {
        for (int j = y; j < len - i; j++) {
            
        }
    }
}

- (NSArray<NSString *> *)nextTurn:(int)i step:(int)j {
    int len = (int)(self.originArr.count);
    
    for (int i = 0; i < len; i++) {
        
        
    }
    
    return 0;
}

- (NSArray<NSString *> *)lastTurn:(int)i step:(int)j {
    
    return 0;
}

- (void)initializeWithArray:(NSArray *)array order:(SortOrder)order {
    self.sortOrder = order;
    self.originArr = array;
    
}




@end

