//
//  BubbleSorter1.m
//  SortReveal
//
//  Created by Eric on 2018/4/18.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "LinearSorter.h"
#import "PinYin4Objc.h"
 

@implementation LinearSorter

///返回1则要交换
- (bool)compareAtIndex_a:(int)a b:(int)b {
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
        //如果是a9和a10，哪个大？思路：带汉字的，都先转成拼音，李 -- 林，然后对于数字，采用智能比较。ASCII内的都是按char比较，即apple自带的
        return [self compareByAutomatic:x with:y order:asc];
    }
 
}

- (void)swap_a:(int)i b:(int)j {
    NSString *temp = dataArr[i];
    dataArr[i] = dataArr[j];
    dataArr[j] = temp;
}

@end
