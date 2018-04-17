//
//  Protocols.h
//  SortReveal
//
//  Created by Eric on 2018/4/16.
//  Copyright © 2018 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol Sorter <NSObject>

- (void)next;

- (void)last;

 
@end


@protocol SimpleTransfer <NSObject>

- (void)transferData:(id)data;

@end



