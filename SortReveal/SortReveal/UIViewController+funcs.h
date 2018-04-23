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
