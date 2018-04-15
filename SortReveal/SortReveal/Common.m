//
//  Common.m
//  SortReveal
//
//  Created by Eric on 2018/4/10.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "Common.h"

NSNotificationName const ELSplitVCShouldDismissNotification = @"adcasefawes";

static NSString * docPath = 0;

@interface Config()

@end

@implementation Config


+ (NSString *)documentPath {
    if (!docPath) {
        docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, 1).firstObject;
        docPath = [docPath stringByAppendingPathComponent:SortNameFile];
    }
    return docPath;
}

+ (NSArray *)getSortNameArray {
    return [NSArray arrayWithContentsOfFile:[self documentPath]];
}

+ (void)writeSortNameArray:(NSArray *)arr {
    if (![arr writeToFile:[self documentPath] atomically:0]) {
        [[NSFileManager defaultManager] removeItemAtPath:[self documentPath] error:nil];
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
