//
//  StoreViewController.h
//  GameMenus101 - 4.1
//
//  Created by Paul on 4/14/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Store;

@class StoreViewController;
@protocol StoreViewControllerDelegate <NSObject>

- (void)storeViewControllerDidPressDone:(StoreViewController *)storeViewController;
- (void)storeViewControllerDidBuyGoldenEgg:(StoreViewController *)storeViewController;
- (void)storeViewControllerDidBuyWhiteEgg:(StoreViewController *)storeViewController;

@end

@interface StoreViewController : UIViewController

@property (nonatomic, weak) id<StoreViewControllerDelegate> delegate;
@property (nonatomic, weak) Store *store;
@end
