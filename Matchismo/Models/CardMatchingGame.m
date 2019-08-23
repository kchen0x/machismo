//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by KChen on 2019/8/21.
//  Copyright © 2019 KChen. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSString *status; // of this match result
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, readwrite) NSInteger gameMode;
@end

@implementation CardMatchingGame

static const int DOUBLE_MODE = 0;
static const int TRIPPLE_MODE = 1;
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i ++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
        _gameMode = DOUBLE_MODE; // by default
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *otherCards = [[NSMutableArray alloc] init];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // match against other chosen cards
            for (Card *otherCard in self.cards) {
                _status = card.contents;
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [otherCards addObject:otherCard];
                    if ([otherCards count] == (_gameMode + 1)) {
                        int matchScore = [card match:otherCards];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            for (Card *matchingCard in otherCards) {
                                matchingCard.matched = YES;
                                _status = [_status stringByAppendingString:matchingCard.contents];
                            }
//                            otherCard.matched = YES;
                            card.matched = YES;
                            _status = [@"Matched " stringByAppendingFormat:@"%@ for %d points!", _status, matchScore * MATCH_BONUS];
                        } else {
                            for (Card *matchingCard in otherCards) {
                                matchingCard.chosen = NO;
                                _status = [_status stringByAppendingString:matchingCard.contents];
                            }
                            self.score -= MISMATCH_PENALTY;
                            _status = [@"Mismatched " stringByAppendingFormat:@"%@ for -%d points!", _status, MISMATCH_PENALTY];
//                            otherCard.chosen = NO;
                        }
                        break;
                    }
                    
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (void)changeGameMode:(NSInteger)gameMode
{
    _gameMode = gameMode;
}

@end
