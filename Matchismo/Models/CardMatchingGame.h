//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by KChen on 2019/8/21.
//  Copyright © 2019 KChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : NSObject
- (instancetype)initWithCardCount:(NSInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)changeGameMode:(NSInteger)modeIndex;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSString *status;
@end

NS_ASSUME_NONNULL_END
