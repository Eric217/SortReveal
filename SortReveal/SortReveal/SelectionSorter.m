//
//  SelectionSorter.m
//  SortReveal
//
//  Created by Eric on 2018/4/24.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "Sorters.h"

@implementation SelectionSorter

- (NSDictionary *)nextTurn:(BOOL *)finished {
    int i = self.currentI, j = self.currentJ; //1
    int len = (int)(dataArr.count);
    NSMutableArray *toBeSavedArray = [[NSMutableArray alloc] initWithArray:dataArr copyItems:1];
    if (len == 2) { //1.1
        if ([self compareAtIndex_a:0 b:1]) {
            [self swap_a:0 b:1];
        }
        *finished = 1;
    } else {
        
        bool needSwap = [self compareAtIndex_a:i b:j]; //2
        
        if (j == len-1) {
            self.currentJ = i+2;
            self.currentI++;
            if (self.currentI == len-1) {
                *finished = 1;
            }
        } else {
            self.currentJ++;
        }
 
        if (needSwap) {//6
            [self swap_a:i b:j];
        } else if (!(*finished) && [UserDefault boolForKey:kSkipNullStep]) {//6.1
            return [self nextTurn:finished];
        }
    }
    
    NSArray *data = [[NSArray alloc] initWithArray:dataArr copyItems:0]; //7
    [historyArr addObject:@{kDataArr: toBeSavedArray, kHistoryPosition: NSStringFromCGPoint(CGPointMake(i, j))}]; //10
    
    if (*finished) {//8
        return @{kDataArr: data};
    } else {//9
        NSString *num0 = [NSString stringWithFormat:@"%d", self.currentI];
        NSString *num1 = [NSString stringWithFormat:@"%d", self.currentJ];
        //TODO: - color
        return @{kDataArr: data, kPositionArr: @[num0, num1], kTitleArr: @[@"i", @"j"]};
    }
}

- (NSDictionary *)nextRow:(BOOL *)finished {
    int j = self.currentJ, i = self.currentI; //1
    NSMutableArray *toBeSavedArray = [[NSMutableArray alloc] initWithArray:dataArr copyItems:1];
    int len = (int)(dataArr.count);

    bool swapped = 0; //1.1
    
    for (int m = j; m < len; m++) { //2
        if ([self compareAtIndex_a:i b:m]) {
            swapped = 1;
            [self swap_a:i b:m];
        }
    }
    self.currentI++;
    self.currentJ = i+2;
    if (self.currentI == len-1) {
        *finished = 1;
    }
 
    if (!swapped && !(*finished) && [NSUserDefaults.standardUserDefaults boolForKey:kSkipNullStep]) {
        return [self nextRow:finished];
    }
    
    [historyArr addObject:@{kDataArr: toBeSavedArray, kHistoryPosition: NSStringFromCGPoint(CGPointMake(i, j))}];
    NSArray *data = [[NSArray alloc] initWithArray:dataArr copyItems:0]; //
    if (*finished) {
        return @{kDataArr: data};
    } else {
        NSString *num0 = [NSString stringWithFormat:@"%d", self.currentI];
        NSString *num1 = [NSString stringWithFormat:@"%d", self.currentJ];
 
        return @{kDataArr: data, kPositionArr: @[num0, num1], kTitleArr: @[@"i", @"j"]};
    }
}

- (void)lastStep {
    NSDictionary *d = [historyArr lastObject];
    CGPoint p = CGPointFromString(d[kHistoryPosition]);
    dataArr = d[kDataArr];
    [historyArr removeLastObject];
    self.currentJ = p.y;
    self.currentI = p.x;
    
}

- (void)initializeWithArray:(NSMutableArray *)array order:(SortOrder)order {
    [super initializeWithArray:array order:order];
    
    self.currentI = 0;
    self.currentJ = 1;
}


@end


