//
//  GameViewController.h
//  GameMenus101 - 1.2
//
//  Created by Paul on 4/14/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Store;

// Forward declaration
@class GameViewController;
@protocol GameViewControllerDelegate <NSObject>

- (void)gameViewControllerDidPressPause:(GameViewController *)gameViewController;

// end game conditions
- (void)gameViewControllerDidFinishGame:(GameViewController *)gameViewController score:(int)score;

@end


@interface GameViewController : UIViewController

@property (nonatomic, weak) id<GameViewControllerDelegate> delegate;
@property (nonatomic, weak) Store *store;

- (void)pause;
- (void)play;


@end
