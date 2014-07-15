//
//  ViewController.m
//  GameMenus101
//
//  Created by Paul on 4/14/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "ViewController.h"
#import "GameViewController.h"
#import "PauseViewController.h"

@interface ViewController () <GameViewControllerDelegate, PauseViewControllerDelegate> {
    
    GameViewController *_gameViewController;
    PauseViewController *_pauseViewController;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _gameViewController = [[GameViewController alloc] init];
    _gameViewController.delegate = self;
    
    _pauseViewController = [[PauseViewController alloc] init];
    _pauseViewController.delegate = self;
}

- (IBAction)playButtonPressed:(id)sender {
    NSLog(@"Play");
    
    // Game Controller
    [self showViewController:_gameViewController];
}

- (IBAction)storeButtonPressed:(id)sender {
    NSLog(@"Store");
    
    // Store Controller
}

- (void)showViewController:(UIViewController *)viewController {
    
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
    viewController.view.frame = self.view.bounds; // always set the frame

    // Animation
    viewController.view.alpha = 0;
    
    // offscreen coordinate (above the top)
    // self.view.bounds.origin.x
    
    // This will start offscreen
    viewController.view.frame = CGRectMake(CGRectGetMinX(self.view.bounds),
                                           -CGRectGetHeight(self.view.bounds),
                                           CGRectGetWidth(self.view.bounds),
                                           CGRectGetHeight(self.view.bounds));
    
    [UIView animateWithDuration:0.5 animations:^{
        viewController.view.alpha = 1;
        viewController.view.frame = self.view.bounds; // don't use frame
    }];
    
}

- (void)hideViewController:(UIViewController *)viewController {
    
    [viewController willMoveToParentViewController:nil];
    [viewController removeFromParentViewController];
    
    
    // Animation
    
    [UIView animateWithDuration:.5 animations:^{
        viewController.view.alpha = 0;
        
        // Move offscreen
        viewController.view.frame = CGRectMake(CGRectGetMinX(self.view.bounds),
                                               -CGRectGetHeight(self.view.bounds),
                                               CGRectGetWidth(self.view.bounds),
                                               CGRectGetHeight(self.view.bounds));
        
    } completion:^(BOOL finish) {
        [viewController.view removeFromSuperview];
    }];
    
}


#pragma mark - GameViewControllerDelegate Methods 

- (void)gameViewControllerDidPressPause:(GameViewController *)gameViewController {
    NSLog(@"Pause");
    
    // Test hiding
//    [self hideViewController:_gameViewController];
    
    [self showViewController:_pauseViewController];
}

- (void)gameViewControllerDidFinishGame:(GameViewController *)gameViewController score:(int)score {
    NSLog(@"Did finish: %d", score);
}

#pragma mark - PauseViewControllerDelegate Methods

- (void)pauseViewControllerDidPressPlay:(PauseViewController *)pauseViewController {
    NSLog(@"Play");
    
    [self hideViewController:_pauseViewController];
}

- (void)pauseViewControllerDidPressStore:(PauseViewController *)pauseViewController {
    NSLog(@"Store");
}

- (void)pauseViewControllerDidPressMenu:(PauseViewController *)pauseViewController {
    NSLog(@"Menu");
    
    [self hideViewController:_pauseViewController];
    [self hideViewController:_gameViewController];
}








@end
