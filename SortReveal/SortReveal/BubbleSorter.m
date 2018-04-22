//
//  BubbleSorter.m
//  SortReveal
//
//  Created by Eric on 2018/4/18.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "Sorters.h"

@interface BubbleSorter ()

@property (assign) BOOL newRow;

@end


@implementation BubbleSorter

- (NSDictionary *)nextTurn:(BOOL *)finished {
    int i = self.currentI, j = self.currentJ;

    if (dataArr.count == 2) {
        if ([self compare_a:0 b:1]) {
            [self swap_a:0 b:1];
        }
        *finished = 1;
    } else {
        if (j == i - 2) {
            self.currentJ = 0;
            --self.currentI;
            _newRow = 1;
            
        } else {
            _newRow = 0;
            ++self.currentJ;
        }
        
        j = self.currentJ;
        
        if (self.currentI == 2 && j == 0) {
            *finished = 1;
        }
        
        if ([self compare_a:j b:j+1]) {
            [self swap_a:j b:j+1];
        } else if (*finished)  {
            return 0;
        } else if ([NSUserDefaults.standardUserDefaults boolForKey:kSkipNullStep]) {
            return [self nextTurn:finished];
        }
    
    }
    NSString *num0 = [NSString stringWithFormat:@"%d", j];
    NSString *num1 = [NSString stringWithFormat:@"%d", j+1];
    NSString *numI = [NSString stringWithFormat:@"%d", i];
    NSString *positions[3];
    positions[0] = num0;
    positions[1] = num1;
    positions[2] = numI;
    
    NSString *titles[3];
    titles[0] = @"j";
    titles[1] = @"j+1";
    titles[2] = @"i";
    NSArray *data = [[NSArray alloc] initWithArray:dataArr copyItems:1];
    //NSArray *color = [NSArray arrayWithObjects:NSString stri UIColor.blackColor count:1];
    
    return @{kDataArr: data, kPositionArr: @[num0, num1, numI], kTitleArr: @[@"j", @"j+1", @"i"]};
}

- (NSDictionary *)nextRow:(BOOL *)finished {
    int j = self.currentJ, i = self.currentI;
    
    if (i <= 2) {
        return 0;
    }
    
    if (!_newRow && j == i-2) {
        i--;
        j = 0;
    } else {
        j++;
    }
    
    self.currentJ = j;
    self.currentI = i;
    
    for (int m = 0; m < i - 1; m++) {
        if ([self compare_a:m b:m+1]) {
            [self swap_a:m b:m+1];
        }
    }
    
    if (i == 2) {
        *finished = 1;
    }
    return 0;
//    return [[NSArray alloc] initWithArray:dataArr copyItems:1];
}

- (NSArray<NSString *> *)lastTurn:(BOOL *)finished {
    
    return 0;
}
 
- (NSArray<NSString *> *)lastRow:(BOOL *)finished {
    return 0;
}

- (void)initializeWithArray:(NSMutableArray *)array order:(SortOrder)order {
    self.sortOrder = order;
    dataArr = [[NSMutableArray alloc] initWithArray:array copyItems:1];
    self.currentI = (int)(array.count);
    self.currentJ = 0;
    _newRow = 0;
}


@end

