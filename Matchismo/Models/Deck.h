//
//  Deck.h
//  Matchismo
//
//  Created by KChen on 2019/7/29.
//  Copyright © 2019 KChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
- (Card *)drawRandomCard;

@end

NS_ASSUME_NONNULL_END
