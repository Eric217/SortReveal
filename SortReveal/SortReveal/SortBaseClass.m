//
//  SortBaseClass.m
//  SortReveal
//
//  Created by Eric on 2018/4/25.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "SortBaseClass.h"
#import "PinYin4Objc.h"

@implementation SortBaseClass

///返回1则要交换
- (bool)compareAtIndex_a:(int)a b:(int)b {
    NSString *x = dataArr[a];
    NSString *y = dataArr[b];
    return [self compareElement_a:x b:y];
}

///返回1则要交换
- (bool)compareElement_a:(NSString *)x b:(NSString *)y {
    SortOrder order = self.sortOrder;
    bool asc = order % 10; //降序为true 升序则false
    NSUInteger i = order/10; //0 num, 1 char, 2 dict, 3 auto
    
    if (i == 0) {
        double x1 = x.doubleValue, y1 = y.doubleValue;
        return [self compareByNumber:x1 with:y1 order:asc];
    } else if (i == 1) { //二竟然比三大: 20108 VS 19977
        return [self compareByChar:x with:y order:asc];
    } else if (i == 2) {
        return [self compareByDict:x with:y order:asc];
    } else if (i == 3) {
        //default asc. false.
        asc = [NSUserDefaults.standardUserDefaults boolForKey:kAutomaticOrderASD];
        //如果是a9和a10，哪个大？思路：带汉字的，都先转成拼音，李 -- 林，然后对于数字，采用智能比较。ASCII内的都是按char比较，即apple自带的
        return [self compareByAutomatic:x with:y order:asc];
    }
    return 0;
}

- (void)swap_a:(int)i b:(int)j {
    NSString *temp = dataArr[i];
    dataArr[i] = dataArr[j];
    dataArr[j] = temp;
}


- (bool)compareByDict:(NSString *)a with:(NSString *)b order:(bool)lower {
    
    HanyuPinyinOutputFormat *outputFormat = [HanyuPinyinOutputFormat commonFormat];

    //TODO: - 每提取出一个char比较一次，比较省时间
    NSString *a1 = [PinyinHelper toHanyuPinyinStringWithSourceString:a withPinyinFormat:outputFormat bySeperator:@""];
    NSString *a2 = [PinyinHelper toHanyuPinyinStringWithSourceString:b withPinyinFormat:outputFormat bySeperator:@""];
    
    return [self compareByChar:a1 with:a2 order:lower];
}

- (bool)compareByChar:(NSString *)a with:(NSString *)b order:(bool)lower {
    int numeric = [NSUserDefaults.standardUserDefaults boolForKey:kNumericCompare] ? 64 : 0;
    int caseInsensitive = [UserDefault boolForKey: kIgnoringCases];
    NSUInteger r = [a compare:b options:numeric|caseInsensitive]; //打开位
    return [self yihuo_r:r lower:lower];
}

- (bool)yihuo_r:(NSUInteger)r lower:(bool)lower {
    if (r == 0)
        return 0;
    bool m = r == -1;
    return (m && lower) || !(m || lower);
}

- (bool)compareByNumber:(double)a with:(double)b order:(bool)lower {
    return lower ? a < b : a > b;
}

- (bool)compareByAutomatic:(NSString *)a with:(NSString *)b order:(bool)lower {
    
    return [self compareByDict:a with:b order:lower];
}

- (instancetype)init {
    self = [super init];
    historyArr = [NSMutableArray new];
    return self;
}

///必须是新构造的array，再retain一次原元素（不用copy items）
- (void)initializeWithArray:(NSMutableArray *)array order:(SortOrder)order {
    self.sortOrder = order;
    dataArr = [[NSMutableArray alloc] initWithArray:array];
}

@end

