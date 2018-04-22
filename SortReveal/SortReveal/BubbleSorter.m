//
//  BubbleSorter.m
//  SortReveal
//
//  Created by Eric on 2018/4/18.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "Sorters.h"

@interface BubbleSorter ()

@end


@implementation BubbleSorter

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (!self->historyArr) {
            self->historyArr = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (NSDictionary *)nextTurn:(BOOL *)finished { //整体思路先把 *.* 去掉，只看 *
    int i = self.currentI, j = self.currentJ; //1

    if (dataArr.count == 2) { //1.1
        if ([self compare_a:0 b:1]) {
            [self swap_a:0 b:1];
        }
        *finished = 1;
    } else {
        
        bool needSwap = [self compare_a:j b:j+1]; //2

        if (j == i - 2) { //3
            self.currentJ = 0;
            --self.currentI;
 
        } else { //4
            ++self.currentJ;
        }
        if (self.currentI == 1 && self.currentJ == 0) {//5
            *finished = 1;
        }

        if (needSwap) {//6
            [self swap_a:j b:j+1];
        } else if (!(*finished) && [NSUserDefaults.standardUserDefaults boolForKey:kSkipNullStep]) {//6.1
            return [self nextTurn:finished];
        }
    }
    NSArray *data = [[NSArray alloc] initWithArray:dataArr copyItems:1]; //7
    [historyArr addObject:NSStringFromCGPoint(CGPointMake(i, j))]; //10
    
    if (*finished) {//8
        NSDictionary *d = @{kDataArr: data};
        //[historyArr addObject:d];
        return d;
    } else {//9
        NSString *num0 = [NSString stringWithFormat:@"%d", self.currentJ];
        NSString *num1 = [NSString stringWithFormat:@"%d", self.currentJ+1];
        NSString *numI = [NSString stringWithFormat:@"%d", self.currentI];
        //TODO: - color
        //NSArray *color = [NSArray arrayWithObjects:NSString stri UIColor.blackColor count:1];
        return @{kDataArr: data, kPositionArr: @[num0, num1, numI], kTitleArr: @[@"j", @"j+1", @"i"]};
    }
}

- (NSDictionary *)nextRow:(BOOL *)finished {
    int j = self.currentJ, i = self.currentI; //1
    bool swapped = 0; //1.1
    
    for (int m = j; m < i - 1; m++) { //2
        if ([self compare_a:m b:m+1]) {
            swapped = 1;
            [self swap_a:m b:m+1];
        }
    }
    self.currentI--;
    self.currentJ = 0;
    
    if (self.currentI == 1) {
        *finished = 1;
    }
    
    if (!swapped && !(*finished) && [NSUserDefaults.standardUserDefaults boolForKey:kSkipNullStep]) {
        return [self nextRow:finished];
    }
    
    [historyArr addObject:NSStringFromCGPoint(CGPointMake(i, j))];
    NSArray *data = [[NSArray alloc] initWithArray:dataArr copyItems:1]; //
    if (*finished) {//
        return @{kDataArr: data};
    } else {
        NSString *num0 = [NSString stringWithFormat:@"%d", self.currentJ];
        NSString *num1 = [NSString stringWithFormat:@"%d", self.currentJ+1];
        NSString *numI = [NSString stringWithFormat:@"%d", self.currentI];
        //TODO: - color
        return @{kDataArr: data, kPositionArr: @[num0, num1, numI], kTitleArr: @[@"j", @"j+1", @"i"]};
    }
}

- (void)lastStep {
    CGPoint p = CGPointFromString([historyArr lastObject]);
    [historyArr removeLastObject];
    self.currentJ = p.y;
    self.currentI = p.x;
}
 

- (void)initializeWithArray:(NSMutableArray *)array order:(SortOrder)order {
    self.sortOrder = order;
    dataArr = [[NSMutableArray alloc] initWithArray:array copyItems:1];
    self.currentI = (int)(array.count);
    self.currentJ = 0;
    
}


@end

