//
//  Common.h
//  SortReveal
//
//  Created by Eric on 2018/4/10.
//  Copyright © 2018 Eric. All rights reserved.
//

#ifndef Common_h
#define Common_h
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnullability-completeness"
#import <UIKit/UIKit.h>

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
#define kIgnoringCases @"imngfadsacxses"


//MARK: - display cell data source
#define kDataArr @"dataArr"
#define kColorArr @"colorArr"
#define kPositionArr @"positionsArr"
#define kTitleArr @"titleArray"
#define kCommingText @"wsgfwsew"

#define kHistoryPosition @"grsaereshtbed"


#define UnitSizeDefault 44
#define TreeFontDefault 24
#define SepaWidth 1.52*UnitSize
#define LineWidth 2
#define UnderTreeH 68*UnitSize/UnitSizeDefault

#define kSortOrder @"sortType"
#define kSortType @"sortOrder"

//MARK: - noti names
UIKIT_EXTERN NSNotificationName _Nonnull const ELTextFieldShouldResignNotification;

UIKIT_EXTERN CGFloat UnitSize;
UIKIT_EXTERN CGFloat TreeFont;

//MARK: - enum and options
typedef NS_ENUM(NSUInteger, SortType) {
    SortTypeBubble = 0,
    SortTypeInsertion = 2,
    SortTypeHeap = 3,
    SortTypeSelection = 1,
    SortTypeFast = 4,
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

typedef NS_ENUM(NSUInteger, ScreenMode) {

    ScreenModeFloatingOrThirth = 0,
//    ScreenModeHalfIpad,
//    ScreenModeTwoThirth,
//    ScreenModeFullScreen,
//    ScreenModeCanPullHideLeft,
//    ScreenModeCanShowBoth,
//    ScreenModeNoSplit,
};

typedef NS_ENUM(NSUInteger, ExecuteWay) {
    ExecuteWayStep = 0,
    ExecuteWayGroup = 1,
};


//MARK: - REAL COMMON

//MARK: - convenient marcos
#define ScreenW UIScreen.mainScreen.bounds.size.width
#define ScreenH UIScreen.mainScreen.bounds.size.height

#define IPHONE4 (ScreenH == 480 || ScreenW == 480)
#define IPHONE5 (ScreenH == 568 || ScreenW == 568)
#define IPHONE6 (ScreenH == 667 || ScreenW == 667)
#define IPHONE6P (ScreenH == 736 || ScreenW == 736)
#define IPhoneX (ScreenH == 812 || ScreenW == 812)
#define IPADPro (ScreenH == 1366 || ScreenW == 1366)

#define UserDefault NSUserDefaults.standardUserDefaults
#define systemBlue [UIColor colorWithRed:0 green:111.0/255 blue:1 alpha:1]
#define IPAD (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
#define IPHONE (!IPAD)

//MARK: - funcs
#define DISPATCH_AT_ONCE(block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ block(); })

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
+ (void)postNotification:(NSNotificationName)name message:(nullable NSDictionary *)info;
+ (void)removeObserver:(id)obj;

+ (NSIndexPath *)idxPath:(NSInteger)item;
+ (NSIndexPath *)idxPathS:(NSInteger)section item:(NSInteger)item;

+ (NSString *)documentPath;
+ (NSArray *)getArrayDataFromFile:(NSString *)name;
+ (void)writeArrayToFile:(NSString *)file data:(NSArray *)arr;

+ (CGFloat)v_pad:(CGFloat)ipad plus:(CGFloat)b p:(CGFloat)s min:(CGFloat)ss;

@end


#pragma clang diagnostic pop
#endif
