//
//  SortReveal
//
//  Created by Eric on 2018/4/26.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "Sorters.h"

#define ELVec4 CGRect

@interface QuickSorter ()

@property (assign) BOOL whileI;
@property (assign) BOOL shouldSwap;

@property (assign) int justGrouped;  //!< 不用记录到 history

@property (nonatomic, copy) NSMutableArray<NSMutableArray *> *stackArray;
@property (nonatomic, copy) NSMutableArray<NSString *> *scopeStack;

@end
 
@implementation QuickSorter

- (NSDictionary *)nextRow:(BOOL *)finished {
    
    ELVec4 histV = CGRectMake(self.currentI, self.currentJ, _whileI, _shouldSwap);
    //int len = (int)(dataArr.count);
    NSMutableArray *toBeSavedArray = [[NSMutableArray alloc] initWithArray:dataArr];
    NSMutableArray *toBeSavedStack = [[NSMutableArray alloc] initWithArray:_scopeStack];
    
    if (_whileI) {
        
        if (_shouldSwap) {
            if (self.currentJ <= self.currentI) {
                NSString *t = [self pivot];
                CGPoint p = CGPointFromString(_scopeStack.lastObject);
                dataArr[int(p.x)] = dataArr[self.currentJ];
                dataArr[self.currentJ] = t;
                [_scopeStack removeLastObject];
                if (self.currentJ+1 < p.y-1)
                    [_scopeStack addObject:NSStringFromCGPoint(CGPointMake(self.currentJ+1, p.y))];
                if (p.x < self.currentJ-1)
                    [_scopeStack addObject:NSStringFromCGPoint(CGPointMake(p.x, self.currentJ))];
                if (_scopeStack.count == 0) {
                    *finished = 1;
                } else {
                    p = CGPointFromString(_scopeStack.lastObject);
                    _justGrouped = self.currentJ;
                    self.currentI = int(p.x);
                    self.currentJ = int(p.y);
                }
                
            } else {
                [self swap_a:self.currentJ b:self.currentI];
            }
            _shouldSwap = 0;
        } else {
            int stackTopJ = [self stackTop].y;
            
            do {
                self.currentI++;
                
            } while (self.currentI != stackTopJ && [self compareElement_a:[self pivot] b:dataArr[self.currentI]]);
            
            _whileI = 0;
            if (self.currentI == stackTopJ) {
                self.currentI--;
                return [self nextRow:finished lastValues:histV];
            } 
            
        }
    
    } else { //While J
        int stackBottomI = [self stackTop].x-1;
        
        do {
            self.currentJ--;
            
        } while (self.currentJ != stackBottomI && ![self compareElement_a:[self pivot] b:dataArr[self.currentJ]]);
        
        if (self.currentJ == stackBottomI) {
            self.currentJ++;
            _whileI = 1;
            _shouldSwap = 1;
            return [self nextTurn:finished lastValues:histV];
        } else {
            _whileI = 1;
            _shouldSwap = 1;
        }
        
    }
    
    [historyArr addObject:@{kDataArr: toBeSavedArray, kHistoryPosition: NSStringFromCGRect(histV)}]; //10
    [_stackArray addObject:toBeSavedStack];
    
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
        if (colors)
            return @{kDataArr: data, kPositionArr: @[num0, num1], kTitleArr: @[@"i", @"j"], kColorArr: @[colors]};
        return @{kDataArr: data, kPositionArr: @[num0, num1], kTitleArr: @[@"i", @"j"]};
    }
    
}

- (NSDictionary *)nextRow:(BOOL *)finished lastValues:(CGRect)values {
    
    NSMutableArray *toBeSavedArray = [[NSMutableArray alloc] initWithArray:dataArr];
    NSMutableArray *toBeSavedStack = [[NSMutableArray alloc] initWithArray:_scopeStack];
    
    
    if (1) { //While J
        int stackBottomI = [self stackTop].x-1;
        
        do {
            self.currentJ--;
            
        } while (self.currentJ != stackBottomI && ![self compareElement_a:[self pivot] b:dataArr[self.currentJ]]);
        
        if (self.currentJ == stackBottomI) {
            self.currentJ++;
            _whileI = 1;
            _shouldSwap = 1;
            return [self nextTurn:finished lastValues:values];
        } else {
            _whileI = 1;
            _shouldSwap = 1;
        }
        
    }
    
    [historyArr addObject:@{kDataArr: toBeSavedArray, kHistoryPosition: NSStringFromCGRect(values)}]; //10
    [_stackArray addObject:toBeSavedStack];
    
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
        if (colors)
            return @{kDataArr: data, kPositionArr: @[num0, num1], kTitleArr: @[@"i", @"j"], kColorArr: @[colors]};
        return @{kDataArr: data, kPositionArr: @[num0, num1], kTitleArr: @[@"i", @"j"]};
    }
    
}

- (NSDictionary *)nextTurn:(BOOL *)finished {
    
    ELVec4 histV = CGRectMake(self.currentI, self.currentJ, _whileI, _shouldSwap);
    //int len = (int)(dataArr.count);
    NSMutableArray *toBeSavedArray = [[NSMutableArray alloc] initWithArray:dataArr];
    NSMutableArray *toBeSavedStack = [[NSMutableArray alloc] initWithArray:_scopeStack];
    
    if (_whileI) {
        
        if (_shouldSwap) {
            if (self.currentJ <= self.currentI) {
                NSString *t = [self pivot];
                CGPoint p = CGPointFromString(_scopeStack.lastObject);
                dataArr[int(p.x)] = dataArr[self.currentJ];
                dataArr[self.currentJ] = t;
                [_scopeStack removeLastObject];
                if (self.currentJ+1 < p.y-1)
                    [_scopeStack addObject:NSStringFromCGPoint(CGPointMake(self.currentJ+1, p.y))];
                if (p.x < self.currentJ-1)
                    [_scopeStack addObject:NSStringFromCGPoint(CGPointMake(p.x, self.currentJ))];
                if (_scopeStack.count == 0) {
                    *finished = 1;
                } else {
                    p = CGPointFromString(_scopeStack.lastObject);
                    _justGrouped = self.currentJ;
                    self.currentI = int(p.x);
                    self.currentJ = int(p.y);
                }
                
            } else {
                [self swap_a:self.currentJ b:self.currentI];
            }
            _shouldSwap = 0;
        } else {
            ++self.currentI;
            if (self.currentI == [self stackTop].y) {
                self.currentI--;
                _whileI = 0;
                return [self nextTurn:finished lastValues:histV];
            } else if (![self compareElement_a:[self pivot] b:dataArr[self.currentI]]) {
                _whileI = 0;
            }
        }
        
    } else { //While J
        
        --self.currentJ;
        if (self.currentJ == [self stackTop].x-1) {
            self.currentJ++;
            _whileI = 1;
            _shouldSwap = 1;
            return [self nextTurn:finished lastValues:histV];
        } else if ([self compareElement_a:[self pivot] b:dataArr[self.currentJ]]) {
            _whileI = 1;
            _shouldSwap = 1;
        }
        
    }
    
    [historyArr addObject:@{kDataArr: toBeSavedArray, kHistoryPosition: NSStringFromCGRect(histV)}]; //10
    [_stackArray addObject:toBeSavedStack];
    
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
        if (colors)
            return @{kDataArr: data, kPositionArr: @[num0, num1], kTitleArr: @[@"i", @"j"], kColorArr: @[colors]};
        return @{kDataArr: data, kPositionArr: @[num0, num1], kTitleArr: @[@"i", @"j"]};
    }
    
    
}

- (CGPoint)stackTop {
    return CGPointFromString(_scopeStack.lastObject);
}

- (NSDictionary *)initialSortData {
    int c = (int)dataArr.count;
    if (c == 1)
        return @{kDataArr: dataArr.copy};
    return @{kDataArr: dataArr.copy, kTitleArr: @[@"i", @"j"],
             kPositionArr: @[@"0", [NSString stringWithFormat:@"%d", c]]};
}

- (void)lastStep {
    NSDictionary *d = [historyArr lastObject];
    CGRect r = CGRectFromString(d[kHistoryPosition]);
    dataArr = d[kDataArr];
    [historyArr removeLastObject];
    self.currentI = r.origin.x;
    self.currentJ = r.origin.y;
    self.whileI   = r.size.width;
    self.shouldSwap = r.size.height;
    _scopeStack = _stackArray.lastObject;
    [_stackArray removeLastObject];
}

- (NSString *)pivot {
    return dataArr[int(CGPointFromString(_scopeStack.lastObject).x)];
}

- (void)initializeWithArray:(NSMutableArray *)array order:(SortOrder)order {
    [super initializeWithArray:array order:order];
    self.currentI = 0;
    self.currentJ = (int)(array.count);
    _whileI = 1;
    _shouldSwap = 0;
    _justGrouped = 0;
    _scopeStack = [[NSMutableArray alloc] init];
    [_scopeStack addObject:NSStringFromCGPoint(CGPointMake(0, self.currentJ))];
    _stackArray = [[NSMutableArray alloc] init];
    [_stackArray addObject:_scopeStack];
}

- (NSDictionary *)nextTurn:(BOOL *)finished lastValues:(ELVec4)values {
    
    
    NSMutableArray *toBeSavedArray = [[NSMutableArray alloc] initWithArray:dataArr];
    NSMutableArray *toBeSavedStack = [[NSMutableArray alloc] initWithArray:_scopeStack];

    if (_whileI) {
        
        if (_shouldSwap) {
            if (self.currentJ <= self.currentI) {
                NSString *t = [self pivot];
                CGPoint p = CGPointFromString(_scopeStack.lastObject);
                dataArr[int(p.x)] = dataArr[self.currentJ];
                dataArr[self.currentJ] = t;
                [_scopeStack removeLastObject];
                if (self.currentJ+1 < p.y-1)
                    [_scopeStack addObject:NSStringFromCGPoint(CGPointMake(self.currentJ+1, p.y))];
                if (p.x < self.currentJ-1)
                    [_scopeStack addObject:NSStringFromCGPoint(CGPointMake(p.x, self.currentJ))];
                if (_scopeStack.count == 0) {
                    *finished = 1;
                } else {
                    p = CGPointFromString(_scopeStack.lastObject);
                    _justGrouped = self.currentJ;
                    self.currentI = int(p.x);
                    self.currentJ = int(p.y);
                }
                
            } else {
                [self swap_a:self.currentJ b:self.currentI];
            }
            _shouldSwap = 0;
        } else {
            ++self.currentI;
            if (self.currentI == [self stackTop].y) { //not exec.
                self.currentI--; _whileI = 0;
                return [self nextTurn:finished lastValues:values];
                
            } else if (![self compareElement_a:[self pivot] b:dataArr[self.currentI]]) {
                _whileI = 0;
            }
        }
        
    } else { //While J
        
        --self.currentJ;
        if (self.currentJ == [self stackTop].x-1) { //not exec.
            self.currentJ++;_whileI = 1;_shouldSwap = 1;
            return [self nextTurn:finished lastValues:values];
        
        } else if ([self compareElement_a:[self pivot] b:dataArr[self.currentJ]]) {
            _whileI = 1;
            _shouldSwap = 1;
        }
        
    }
    
    [historyArr addObject:@{kDataArr: toBeSavedArray, kHistoryPosition: NSStringFromCGRect(values)}]; //10
    [_stackArray addObject:toBeSavedStack];

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
        if (colors)
            return @{kDataArr: data, kPositionArr: @[num0, num1], kTitleArr: @[@"i", @"j"], kColorArr: @[colors]};
        return @{kDataArr: data, kPositionArr: @[num0, num1], kTitleArr: @[@"i", @"j"]};
    }
    
}




@end

