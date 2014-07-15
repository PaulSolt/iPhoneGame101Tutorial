//
//  PauseViewController.h
//  GameMenus101 - 2.1
//
//  Created by Paul on 4/14/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PauseViewController;
@protocol PauseViewControllerDelegate <NSObject>

- (void)pauseViewControllerDidPressPlay:(PauseViewController *)pauseViewController;
- (void)pauseViewControllerDidPressStore:(PauseViewController *)pauseViewController;
- (void)pauseViewControllerDidPressMenu:(PauseViewController *)pauseViewController;

@end

@interface PauseViewController : UIViewController

@property (nonatomic, weak) id<PauseViewControllerDelegate> delegate;

@end
