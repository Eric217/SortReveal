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
NSNotificationName const ELTextFieldShouldResignNotification = @"dafwqswqGTR";

static NSString * docPath = 0;
static UIImage * _backImage = 0;
static UIImage * _pushImage = 0;
 
@interface Config()


@end

@implementation Config

///need to free points and alter coordinate, level: _height-2 ... 0
+ (CGPoint *)getLocaWithHeight:(int)h startAngle:(CGFloat)a angleReducer:(void(^)(int level, CGFloat *))handler {
    int arrSize = pow(2, h)-1;
    CGPoint *points = (CGPoint *)malloc(arrSize*sizeof(CGPoint));
    
    //最底层单独确定位置
    int s = pow(2, h-1) - 1;
    CGFloat bottom = LineWidth/2;
    CGFloat left = LineWidth/2;
    CGFloat angle = a;
    
    for (int i = s; i <= 2*s; i++) {
        points[i] = CGPointMake(left+0.5*UnitSize+(i-s)*SepaWidth, UnitSize*0.5+bottom);
    }
    
    //其余层靠子树确定位置
    for (int i = h-2; i >= 0; i--) {
        int s = pow(2, i) - 1;
        for (int j = s; j <= 2*s; j++) {
            int point1Idx = 2*j+1;
            CGFloat x1 = points[point1Idx].x;
            CGFloat lastLevelBian = points[point1Idx+1].x - x1;
            CGFloat x2 = x1 + lastLevelBian/2; //X
            CGFloat y2;
            if (j == s) {
                y2 = points[point1Idx].y + lastLevelBian/2*tan(angle);
                handler(i, &angle);
            } else
                y2 = points[j-1].y;
            points[j] = CGPointMake(x2, y2);
        }
        
    }
 
    return points;
}



+ (void)saveDouble:(double)value forKey:(NSString *)key {
    [NSUserDefaults.standardUserDefaults setDouble:value forKey:key];
    [NSUserDefaults.standardUserDefaults synchronize];
}

+ (double)doubleValue:(NSString *)text {
    NSScanner *scanner = [NSScanner scannerWithString:text];
    double result = 0;
    if (!([scanner scanDouble:&result] && [scanner isAtEnd])) {
        result = 0;
    }
    return result;
}

+ (UIViewController *)viewControllerFromSBName:(NSString *)sbName id:(NSString *)sbId {
    return [[UIStoryboard storyboardWithName:sbName bundle:0] instantiateViewControllerWithIdentifier:sbId];
}

+ (void)addObserver:(id)target selector:(SEL)func notiName:(NSNotificationName)name {
    [[NSNotificationCenter defaultCenter] addObserver:target selector:func name:name object:nil];
}

+ (void)postNotification:(NSNotificationName)name message:(nullable NSDictionary *)info {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:info];
}

+ (void)removeObserver:(id)obj {
    [[NSNotificationCenter defaultCenter] removeObserver:obj];
}

+ (NSIndexPath *)idxPath:(NSInteger)item {
    return [NSIndexPath indexPathForItem:item inSection:0];
}

+ (NSIndexPath *)idxPathS:(NSInteger)section item:(NSInteger)item {
    return [NSIndexPath indexPathForItem:item inSection:section];
}


+ (UIImage *)pushImage {
    if (!_pushImage) {
        _pushImage = [UIImage imageNamed:@"pushImage"];
    }
    return _pushImage;
}

+ (UIImage *)backImage {
    if (!_backImage) {
        _backImage = [UIImage imageNamed:@"backImage"];
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

+ (UIBarButtonItem *)customBackBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)selec {
    UIButton *_backButton = [[UIButton alloc] init];
    [_backButton setContentEdgeInsets:UIEdgeInsetsMake(0, -12, 0, 20)];
    [_backButton setTitle:title forState:UIControlStateNormal];
    [_backButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [_backButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [_backButton setImage:[Config backImage] forState:UIControlStateNormal];
    [_backButton addTarget:target action:selec forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:_backButton];
 
}
@end
