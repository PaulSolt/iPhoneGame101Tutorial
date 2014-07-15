//
//  ViewController.m
//  GameMenus101
//
//  Created by Paul on 4/14/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "ViewController.h"
#import "GameViewController.h"

@interface ViewController () {
    
    GameViewController *_gameViewController;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _gameViewController = [[GameViewController alloc] init];
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
    
    [viewController.view removeFromSuperview];
    
    // Animation
    
    [UIView animateWithDuration:.5 animations:^{
        viewController.view.alpha = 0;
    } completion:^(BOOL finish) {
        
    }];
    
}





@end
