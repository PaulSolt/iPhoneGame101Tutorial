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
#import "StoreViewController.h"
#import "Store.h"

NSString *const kStoreFilename = @"store.plist";

@interface ViewController () <GameViewControllerDelegate, PauseViewControllerDelegate,
StoreViewControllerDelegate> {
    
    GameViewController *_gameViewController;
    PauseViewController *_pauseViewController;
    StoreViewController *_storeViewController;
    
    Store *_store;
}

@end

@implementation ViewController

- (NSString *)filepathInDocumentsDirectory:(NSString *)filename {
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:filename];
}

- (BOOL)saveStore {
    NSString *filepath = [self filepathInDocumentsDirectory:kStoreFilename];
    NSLog(@"filepath: %@", filepath);
    BOOL success = [NSKeyedArchiver archiveRootObject:_store toFile:filepath];\
    
    NSLog(@"saveStore: %d", success);
    return success;
}

- (void)loadStore {
    NSLog(@"loadStore");
    NSString *filepath = [self filepathInDocumentsDirectory:kStoreFilename];
    _store = [NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
    
    NSLog(@"store: %@ %d", _store, _store.goldenEggCount);
    if(!_store) {
        _store = [[Store alloc] init];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadStore];

    _gameViewController = [[GameViewController alloc] init];
    _gameViewController.delegate = self;
    _gameViewController.store = _store;
    
    _pauseViewController = [[PauseViewController alloc] init];
    _pauseViewController.delegate = self;
    
    _storeViewController = [[StoreViewController alloc] init];
    _storeViewController.delegate = self;
    _storeViewController.store = _store;
    
    
    
}

- (IBAction)playButtonPressed:(id)sender {
    NSLog(@"Play");
    
    // Game Controller
    [self showViewController:_gameViewController];
}

- (IBAction)storeButtonPressed:(id)sender {
    NSLog(@"Store");
    
    // Store Controller
    [self showViewController:_storeViewController];

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
    
    [_gameViewController pause];
}

- (void)gameViewControllerDidFinishGame:(GameViewController *)gameViewController score:(int)score {
    NSLog(@"Did finish: %d", score);
}

#pragma mark - PauseViewControllerDelegate Methods

- (void)pauseViewControllerDidPressPlay:(PauseViewController *)pauseViewController {
    NSLog(@"Play");
    
    [self hideViewController:_pauseViewController];
    [_gameViewController play];
}

- (void)pauseViewControllerDidPressStore:(PauseViewController *)pauseViewController {
    NSLog(@"Store");
    [self showViewController:_storeViewController];
}

- (void)pauseViewControllerDidPressMenu:(PauseViewController *)pauseViewController {
    NSLog(@"Menu");
    
    [self hideViewController:_pauseViewController];
    [self hideViewController:_gameViewController];
}

#pragma mark - StoreViewControllerDelegate Methods

- (void)storeViewControllerDidPressDone:(StoreViewController *)storeViewController {
    NSLog(@"Done");
    [self hideViewController:_storeViewController];
    
    [self saveStore];
}

- (void)storeViewControllerDidBuyGoldenEgg:(StoreViewController *)storeViewController {
    NSLog(@"Golden");
    
    [self saveStore];
}

- (void)storeViewControllerDidBuyWhiteEgg:(StoreViewController *)storeViewController {
    NSLog(@"White");
    
    [self saveStore];
}




- (BOOL)prefersStatusBarHidden {
    return YES;
}





@end
