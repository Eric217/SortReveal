//
//  UIViewController+funcs.m
//  SortReveal
//
//  Created by Eric on 2018/4/15.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "UIViewController+funcs.h"

@implementation UIViewController (funcs)

- (void)presentAlertWithConfirmAction:(void (^) (UIAlertAction *))handler {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
    [alertC addAction:cancel];
    [alertC addAction:ok];
    [self presentViewController:alertC animated:1 completion:nil];
    
}


@end
