//
//  Card.h
//  Matchismo
//
//  Created by KChen on 2019/7/29.
//  Copyright © 2019 KChen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSString *)otherCards;

@end

NS_ASSUME_NONNULL_END
