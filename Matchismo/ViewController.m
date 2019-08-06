//
//  ViewController.m
//  Matchismo
//
//  Created by KChen on 2019/7/29.
//  Copyright © 2019 KChen. All rights reserved.
//

#import "ViewController.h"
#import "Models/PlayingCardDeck.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) Deck *playingCardDeck;

@end

@implementation ViewController

- (Deck *)playingCardDeck {
    if (!_playingCardDeck) _playingCardDeck = [[PlayingCardDeck alloc] init];
    return _playingCardDeck;
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flipCount changed to %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        NSString *title = [self.playingCardDeck drawRandomCard].contents;
        if (!title) {
            title = @"🚫";
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
            [sender setTitle:title forState:UIControlStateNormal];
            sender.enabled = NO;
        }
        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
        [sender setTitle:title forState:UIControlStateNormal];
        //[sender setTitle:@"A♣️" forState:UIControlStateNormal];
    }
    self.flipCount++;
}

@end
