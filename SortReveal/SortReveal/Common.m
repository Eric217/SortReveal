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
    }
    return docPath;
    
}

+ (NSArray *)getArrayDataFromFile:(NSString *)name {
    
    return [NSArray arrayWithContentsOfFile:[[self documentPath] stringByAppendingPathComponent:name]];

}

+ (void)writeArrayToFile:(NSString *)file data:(NSArray *)arr {
    NSString *path = [[self documentPath] stringByAppendingPathComponent:file];
    if (![arr writeToFile:path atomically:0]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
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
