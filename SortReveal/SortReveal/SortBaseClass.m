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

- (bool)compareByDict:(NSString *)a with:(NSString *)b order:(bool)lower {
    
    HanyuPinyinOutputFormat *outputFormat = [HanyuPinyinOutputFormat commonFormat];

    //TODO: - 每提取出一个char比较一次，比较省时间
    NSString *a1 = [PinyinHelper toHanyuPinyinStringWithSourceString:a withPinyinFormat:outputFormat bySeperator:@""];
    NSString *a2 = [PinyinHelper toHanyuPinyinStringWithSourceString:b withPinyinFormat:outputFormat bySeperator:@""];
    
    return [self compareByChar:a1 with:a2 order:lower];
}

- (bool)compareByChar:(NSString *)a with:(NSString *)b order:(bool)lower {
    bool numeric = [NSUserDefaults.standardUserDefaults boolForKey:kNumericCompare];
    NSUInteger r = numeric ? [a compare:b options:NSNumericSearch] : [a compare:b];
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
    HanyuPinyinOutputFormat *outputFormat = [HanyuPinyinOutputFormat commonFormat];
    
    NSString *a1 = [PinyinHelper toHanyuPinyinStringWithSourceString:a withPinyinFormat:outputFormat bySeperator:@""];
    NSString *a2 = [PinyinHelper toHanyuPinyinStringWithSourceString:b withPinyinFormat:outputFormat bySeperator:@""];
    
    return [self yihuo_r:[a1 compare:a2 options:NSNumericSearch] lower:lower];
}

- (instancetype)init {
    self = [super init];
    if (self && !historyArr)
        historyArr = [[NSMutableArray alloc] init];
    return self;
}

@end

