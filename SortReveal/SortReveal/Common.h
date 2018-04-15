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
#define configSortVCId @"configsortID"
#define sortingVCId @"sortingvcid"


UIKIT_EXTERN NSNotificationName const ELSplitVCShouldDismissNotification;


typedef NS_ENUM(NSUInteger, SortType) {
    SortTypeBubble = 0,
    SortTypeInsertion = 2,
    SortTypeHeap = 3,
    SortTypeSelection = 1,
    
   
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

+ (CGFloat)v_pad:(CGFloat)ipad plus:(CGFloat)b p:(CGFloat)s;

+ (NSString *)documentPath;
+ (NSArray *)getSortNameArray;
+ (void)writeSortNameArray:(NSArray *)arr;

@end



#endif /* Common_h */
