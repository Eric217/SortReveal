//
//  Common.m
//  SortReveal
//
//  Created by Eric on 2018/4/10.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "Common.h"
#import "UIImage+operations.h"

NSNotificationName const ELSplitVCShouldDismissNotification = @"adcasefawes";
NSNotificationName const SortingVCShouldStartDisplayNotification = @"dadasfeswqa";

static NSString * docPath = 0;
static UIImage * _backImage = 0;
static UIImage * _pushImage = 0;


@interface Config()

@end

@implementation Config

+ (void)addObserver:(id)target selector:(SEL)func notiName:(NSNotificationName)name {
    [[NSNotificationCenter defaultCenter] addObserver:target selector:func name:name object:nil];
}

+ (void)postNotification:(NSNotificationName)name message:(nullable NSDictionary *)info {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:info];
}

+ (void)removeObserver:(id)obj {
    [[NSNotificationCenter defaultCenter] removeObserver:obj];
}


+ (UIImage *)pushImage {
    if (!_pushImage) {
        _pushImage = [[UIImage imageNamed:@"pushImage"] imageWithColor:UIColor.blackColor];
    }
    return _pushImage;
}

+ (UIImage *)backImage {
    if (!_backImage) {
        _backImage = [[UIImage imageNamed:@"backImage"] imageWithColor:UIColor.blackColor];
    }
    return _backImage;
}


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

+ (CGFloat)v_pad:(CGFloat)ipad plus:(CGFloat)b p:(CGFloat)s min:(CGFloat)ss {
    if (IPAD) {
        return ipad;
    } else if (IPHONE4 || IPHONE5) {
        return ss;
    } else if (IPHONE6) {
        return s;
    } else {
        return b;
    }
}

@end
