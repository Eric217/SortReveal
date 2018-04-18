//
//  Common.h
//  SortReveal
//
//  Created by Eric on 2018/4/10.
//  Copyright © 2018 Eric. All rights reserved.
//

#ifndef Common_h
#define Common_h
#include <UIKit/UIKit.h>

//MARK: - Project Specified
#define SortNameFile @"SortNames.plist"
#define SortOrderFile @"SortOrder.plist"

#define configSortVCId @"configsortID"
#define sortingVCId @"sortingvcid"
#define selectOrderVCId @"selectOrderID"

#define kDataArr @"dataArr"
#define kSortOrder @"sortType"
#define kSortType @"sortOrder"

#define kSkipNullStep @"skip null"

#define systemBlue [UIColor colorWithRed:0 green:111.0/255 blue:1 alpha:1]

UIKIT_EXTERN NSNotificationName const ELSplitVCShouldDismissNotification;
UIKIT_EXTERN NSNotificationName const SortingVCShouldStartDisplayNotification;

typedef NS_ENUM(NSUInteger, SortType) {
    SortTypeBubble = 0,
    SortTypeInsertion = 2,
    SortTypeHeap = 3,
    SortTypeSelection = 1,
    
};

///section * 10 + row = raw value
typedef NS_ENUM(NSUInteger, SortOrder) {
    SortOrderNumberA = 0,
    SortOrderNumberD = 1,
    SortOrderCharacA = 10,
    SortOrderCharacD = 11,
    SortOrderDictioA = 20,
    SortOrderDictioD = 21,
    SortOrderAutomatic = 30,
};

 
//MARK: - REAL COMMON
#define ScreenW UIScreen.mainScreen.bounds.size.width
#define ScreenH UIScreen.mainScreen.bounds.size.height

#define IPAD UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad
#define IPHONE4 ScreenH == 480
#define IPHONE5 ScreenH == 568
#define IPHONE6 ScreenH == 667
#define IPHONE6P ScreenH == 736
#define IPhoneX !IPAD && ScreenH > 736
 

@interface Config: NSObject

+ (void)addObserver:(id)target selector:(SEL)func notiName:(NSNotificationName)name;
+ (void)postNotification:(NSNotificationName)name message:(nullable NSDictionary *)info;
+ (void)removeObserver:(id)obj;

+ (UIImage *)pushImage;
+ (UIImage *)backImage;

+ (NSIndexPath *)idxPath:(NSInteger)item;
+ (NSIndexPath *)idxPathS:(NSInteger)section item:(NSInteger)item;

+ (NSString *)documentPath;
+ (NSArray *)getArrayDataFromFile:(NSString *)name;
+ (void)writeArrayToFile:(NSString *)file data:(NSArray *)arr;

+ (CGFloat)v_pad:(CGFloat)ipad plus:(CGFloat)b p:(CGFloat)s min:(CGFloat)ss;

@end



#endif /* Common_h */
