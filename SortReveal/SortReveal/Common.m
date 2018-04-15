//
//  Common.m
//  SortReveal
//
//  Created by Eric on 2018/4/10.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "Common.h"

NSNotificationName const ELSplitVCShouldDismissNotification = @"adcasefawes";

@interface Config()

@end

@implementation Config

+ (NSArray *)getSortNameArray {
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, 1).firstObject;
    docPath = [docPath stringByAppendingPathComponent:SortNameFile];
    return [NSArray arrayWithContentsOfFile:docPath];
}

+ (void)writeSortNameArray:(NSArray *)arr {
    if (![arr writeToFile:docPath atomically:0]) {
        [[NSFileManager defaultManager] removeItemAtPath:docPath error:nil];
    }
}

+ (CGFloat)v_pad:(CGFloat)ipad plus:(CGFloat)b p:(CGFloat)s {
    if (IPAD) {
        return ipad;
    } else if (IPHONE4 || IPHONE5 || IPHONE6) {
        return s;
    } else {
        return b;
    }
}

@end
