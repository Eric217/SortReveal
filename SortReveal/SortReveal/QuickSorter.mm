//
//  SortReveal
//
//  Created by Eric on 2018/4/26.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "Sorters.h"
#import "LinkedStack.hpp"

#define ELVec4 CGRect

@interface QuickSorter ()

@property (assign) BOOL whileI;
@property (assign) BOOL shouldSwap;
@property (assign) int justGrouped;  //!< 不用记录到 history

@property (assign) LinkedStack<ELPoint> scopeStack;

@end
 
@implementation QuickSorter

- (NSDictionary *)nextTurn:(BOOL *)finished {
    
    int i = self.currentI, j = self.currentJ;
    //int len = (int)(dataArr.count);
    NSMutableArray *toBeSavedArray = [[NSMutableArray alloc] initWithArray:dataArr];
    
    if (_whileI) {
        
        if (_shouldSwap) {
            if (self.currentJ <= self.currentI) {
                NSString *t = [self pivot];
                ELPoint p = _scopeStack.Top();
                dataArr[p.i] = dataArr[self.currentJ];
                dataArr[self.currentJ] = t;
                _scopeStack.pop();
                if (self.currentJ+1 < p.j-1)
                    _scopeStack.push({self.currentJ+1, p.j});
                if (p.i < self.currentJ-1)
                    _scopeStack.push({p.i, self.currentJ});
                if (_scopeStack.empty()) {
                    *finished = 1;
                } else {
                    p = _scopeStack.Top();
                    _justGrouped = self.currentJ;
                    self.currentI = p.i;
                    self.currentJ = p.j;
                }
                
            } else {
                [self swap_a:self.currentJ b:self.currentI];
            }
            _shouldSwap = 0;
        } else {
            ++self.currentI;
            if (self.currentI == _scopeStack.Top().j) {
                self.currentI--;
                _whileI = 0;
                return [self nextTurn:finished];
            } else if (![self compareElement_a:[self pivot] b:dataArr[self.currentI]]) {
                _whileI = 0;
            }
        }
    } else {
        --self.currentJ;
        if (self.currentJ == _scopeStack.Top().i-1) {
            self.currentJ++;
            _whileI = 1;
            _shouldSwap = 1;
            return [self nextTurn:finished];
        } else if ([self compareElement_a:[self pivot] b:dataArr[self.currentJ]]) {
            _whileI = 1;
            _shouldSwap = 1;
        }
        
    }
    
    [historyArr addObject:@{kDataArr: toBeSavedArray, kHistoryPosition: NSStringFromCGPoint(CGPointMake(i, j))}]; //10
    
    NSArray *data = dataArr.copy;
    if (*finished) {
        return @{kDataArr: data};
    } else {
        NSString *num0 = [NSString stringWithFormat:@"%d", self.currentI];
        NSString *num1 = [NSString stringWithFormat:@"%d", self.currentJ];
        NSString *colors;
        if (_justGrouped) {
            colors = [NSString stringWithFormat:@"%d", _justGrouped];
            _justGrouped = 0;
        }
        if (colors) {
            return @{kDataArr: data, kPositionArr: @[num0, num1], kTitleArr: @[@"i", @"j"], kColorArr: @[colors]};
        }
        return @{kDataArr: data, kPositionArr: @[num0, num1], kTitleArr: @[@"i", @"j"]};
    }
    
}

- (NSDictionary *)nextRow:(BOOL *)finished {
    return 0;
}


- (NSDictionary *)initialSortData {
    int c = (int)dataArr.count;
    if (c == 1)
        return @{kDataArr: dataArr.copy};
    return @{kDataArr: dataArr.copy, kTitleArr: @[@"i", @"j"],
             kPositionArr: @[@"0", [NSString stringWithFormat:@"%d", c]]};
}

- (void)lastStep {
    
}

- (NSString *)pivot {
    return dataArr[_scopeStack.Top().i];
}

- (void)initializeWithArray:(NSMutableArray *)array order:(SortOrder)order {
    [super initializeWithArray:array order:order];
    self.currentI = 0;
    self.currentJ = (int)(array.count);
    _whileI = 1;
    _shouldSwap = 0;
    _justGrouped = 0;
    _scopeStack = LinkedStack<ELPoint>();
    _scopeStack.push({0 , self.currentJ});
}


@end

