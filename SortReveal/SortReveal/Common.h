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
//MARK: - localized files and properties
#define SortNameFile @"SortNames.plist"
#define SortOrderFile @"SortOrder.plist"
#define SingleStep @"单步执行"
#define GroupStep @"单组跳过"

#define kSkipNullStep @"skip null"
#define kTimeInterval @"dawfewaf"
#define kFlowExecWay @"gresweqwqa"
#define kNumericCompare @"NumericComeufgdsa"
#define kAutomaticOrderASD @"fegrwesadsase"

//MARK: - display cell data source
#define kDataArr @"dataArr"
#define kColorArr @"colorArr"
#define kPositionArr @"positionsArr"
#define kTitleArr @"titleArray"

#define kSortOrder @"sortType"
#define kSortType @"sortOrder"

//MARK: - noti names
UIKIT_EXTERN NSNotificationName const ELSplitVCShouldDismissNotification;
UIKIT_EXTERN NSNotificationName const SortingVCShouldStartDisplayNotification;
UIKIT_EXTERN NSNotificationName const ELTextFieldShouldResignNotification;

//MARK: - enum and options
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

typedef NS_ENUM(NSUInteger, ExecuteWay) {
    ExecuteWayStep = 0,
    ExecuteWayGroup = 1,
};


//MARK: - REAL COMMON

//MARK: - convenient marcos
#define ScreenW UIScreen.mainScreen.bounds.size.width
#define ScreenH UIScreen.mainScreen.bounds.size.height

#define IPHONE4 ScreenH == 480
#define IPHONE5 ScreenH == 568
#define IPHONE6 ScreenH == 667
#define IPHONE6P ScreenH == 736
#define IPhoneX !IPAD && ScreenH > 736

#define UserDefault NSUserDefaults.standardUserDefaults
#define systemBlue [UIColor colorWithRed:0 green:111.0/255 blue:1 alpha:1]
#define IPAD UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad

//MARK: - common and useful funcs
@interface Config: NSObject

+ (void)saveDouble:(double)value forKey:(NSString *)key;
+ (double)doubleValue:(NSString *)text;
+ (UIViewController *)viewControllerFromSBName:(NSString *)sbName id:(NSString *)sbId;

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
+ (UIBarButtonItem *)customBackBarButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)selec;

@end



#endif /* Common_h */
