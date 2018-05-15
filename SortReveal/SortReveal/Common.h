//
//  Common.h
//  SortReveal
//
//  Created by Eric on 2018/4/10.
//  Copyright © 2018 Eric. All rights reserved.
//

#ifndef Common_h
#define Common_h
#import <UIKit/UIKit.h>
#import "Definition.h"


//MARK: - noti names
UIKIT_EXTERN NSNotificationName const ELTextFieldShouldResignNotification;

UIKIT_EXTERN CGFloat UnitSize;
UIKIT_EXTERN CGFloat TreeFont;
 
//MARK: - common and useful funcs
///Config provides common tools
@interface Config: NSObject
 
+ (void)updateUnitSizeAndFontFor:(ScreenMode)screen withTreeSize:(NSUInteger)nodeCount;
+ (int)getTreeHeight:(NSUInteger)count;
+ (CGSize)estimatedSizeThatFitsTree:(NSUInteger)nodeCount bottom:(CGFloat)bottomH;
+ (CGPoint *)getLocaWithHeight:(int)h startAngle:(CGFloat)a angleReducer:(void(^)(int level, CGFloat * angle))handler;
+ (CGSize)sizeForText:(NSString *)str attr:(NSDictionary *)attr maxSize:(CGSize)max orFontS:(CGFloat)fs;

+ (void)saveDouble:(double)value forKey:(NSString *)key;
+ (double)doubleValue:(NSString *)text;

+ (void)addObserver:(id)target selector:(SEL)func notiName:(NSNotificationName)name;
+ (void)postNotification:(NSNotificationName)name message:(NSDictionary *)info;
+ (void)removeObserver:(id)obj;
 
+ (NSString *)documentPath;
+ (NSArray *)getArrayDataFromFile:(NSString *)name;
+ (void)writeArrayToFile:(NSString *)file data:(NSArray *)arr;

+ (CGFloat)v_pad:(CGFloat)ipad plus:(CGFloat)b p:(CGFloat)s min:(CGFloat)ss;

@end

#endif
