//
//  SelectController.h
//  SortReveal
//
//  Created by Eric on 2018/4/24.
//  Copyright © 2018 Eric. All rights reserved.
//

#import "Common.h"
#import "Protocols.h"
#import <UIKit/UIKit.h>

@interface SelectController : UIViewController

@property (strong, nonatomic) UITableView *table;
@property (weak, nonatomic) id <SimpleTransfer> delegate;
@property (copy, nonatomic) NSString *currentSelection;

@end
