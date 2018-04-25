//
//  BubbleSorter1.m
//  SortReveal
//
//  Created by Eric on 2018/4/18.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "SortBaseClass.h"

@implementation SortBaseClass
 
@end



@implementation LinearSorter

///返回1则要交换
- (bool)compare_a:(int)a b:(int)b {
    SortOrder order = self.sortOrder;
    bool asc = order % 10; //降序为true 升序则false
    NSUInteger i = order/10; //0 num, 1 char, 2 dict, 3 auto
    
    NSString *x = dataArr[a];
    NSString *y = dataArr[b];
    
    if (i == 0) {
        double x1 = x.doubleValue, y1 = y.doubleValue;
        return [self compareByNumber:x1 with:y1 order:asc];
    } else if (i == 1) { //二竟然比三大: 20108 VS 19977
        return [self compareByChar:x with:y order:asc];
    } else if (i == 2) {
        return [self compareByDict:x with:y order:asc];
    } else {
        
    }
  
    return 0;
}

- (bool)compareByDict:(NSString *)a with:(NSString *)b order:(bool)lower {



    return 0;
}

- (bool)compareByChar:(NSString *)a with:(NSString *)b order:(bool)lower {
    NSUInteger r = [a compare:b];
    if (r == 0) {
        return 0;
    } else  {
        bool m = r == -1;
        return (m && lower) || !(m || lower);
    }
}

- (bool)compareByNumber:(double)a with:(double)b order:(bool)lower {
    return lower ? a < b : a > b;
}

- (void)swap_a:(int)i b:(int)j {
    NSString *temp = dataArr[i];
    dataArr[i] = dataArr[j];
    dataArr[j] = temp;
}

@end
