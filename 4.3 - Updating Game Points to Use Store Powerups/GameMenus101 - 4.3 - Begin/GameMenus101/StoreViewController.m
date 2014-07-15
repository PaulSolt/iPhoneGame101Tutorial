//
//  StoreViewController.m
//  GameMenus101 - 4.1
//
//  Created by Paul on 4/14/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "StoreViewController.h"

@interface StoreViewController ()
@property (weak, nonatomic) IBOutlet UILabel *goldenEggLabel;
@property (weak, nonatomic) IBOutlet UILabel *whiteEggLabel;

@end

@implementation StoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"store: %@", _store);
    [self refreshStoreUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doneButtonPressed:(id)sender {
    [self.delegate storeViewControllerDidPressDone:self];
}

- (IBAction)buyGoldenEggButtonPressed:(id)sender {
    [self.delegate storeViewControllerDidBuyGoldenEgg:self];
    
    _store.goldenEggCount++;
    [self refreshStoreUI];
}

- (IBAction)buyWhiteEggButtonPressed:(id)sender {
    [self.delegate storeViewControllerDidBuyWhiteEgg:self];
    
    _store.whiteEggCount++;
    [self refreshStoreUI];
}

- (void)refreshStoreUI {
    
    self.goldenEggLabel.text = [@(_store.goldenEggCount) stringValue];
    self.whiteEggLabel.text = [@(_store.whiteEggCount) stringValue];
    
    
}
@end
