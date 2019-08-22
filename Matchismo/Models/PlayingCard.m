//
//  PlayingCard.m
//  Matchismo
//
//  Created by KChen on 2019/7/29.
//  Copyright © 2019 KChen. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;
+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSArray *)validSuits {
    return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}

+ (NSUInteger)maxRank {
    return [[PlayingCard rankStrings] count];
}

- (NSString *)suit {
    return _suit ?_suit : @"?";
}

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.suit == self.suit) {
            score = 1;
        }
        if (otherCard.rank == [self rank]) {
            score = 4;
        }
    }
    
    if ([otherCards count] == 2) {
        PlayingCard *card0 = [otherCards objectAtIndex:0];
        PlayingCard *card1 = [otherCards objectAtIndex:1];
        
        if (card0.suit == card1.suit && card0.suit == self.suit) {
            score = 1;
        } else if (card0.suit == card1.suit || card0.suit == self.suit || card1.suit == self.suit){
            score = 1;
        }
        if (card0.rank == card1.rank && card0.rank == self.rank) {
            score = 20;
        } else if (card0.rank == card1.rank || card0.rank == self.rank || card1.rank == self.rank){
            score = 1;
        }
        
    }
    
    return score;
}

@end
