//
//  UIViewController+funcs.h
//  SortReveal
//
//  Created by Eric on 2018/4/15.
//  Copyright © 2018 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (funcs)

- (void)presentAlertWithConfirmTitle:(NSString *)title message:(NSString *)msg Action:(void (^) (UIAlertAction *))handler;

- (void)pushWithoutBottomBar:(UIViewController *)vc;

@end


@interface UIViewController (ELSplitController)

- (bool)isDevicePortait;

- (bool)isPortrait;

- (bool)isFloatingOrThirth;
    
- (bool)isHalfIpad;
    
- (bool)isTwoThirth;
    
- (bool)isFullScreen;
    
//以下几个函数涉及到split view controller.
- (bool)canPullHideLeft;
    
- (bool)canShowBoth;
    
- (bool)isNoSplit;

- (void)automaticSplitStyle;
- (void)overlaySplitStyle;
- (void)hidePrimarySplitStyle;

@end
