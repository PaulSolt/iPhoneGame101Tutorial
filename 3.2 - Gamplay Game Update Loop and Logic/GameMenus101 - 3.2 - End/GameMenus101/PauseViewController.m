//
//  PauseViewController.m
//  GameMenus101 - 2.1
//
//  Created by Paul on 4/14/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "PauseViewController.h"

@interface PauseViewController ()

@end

@implementation PauseViewController

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
- (IBAction)playButtonPressed:(id)sender {
    [self.delegate pauseViewControllerDidPressPlay:self];
}

- (IBAction)storeButtonPressed:(id)sender {
    [self.delegate pauseViewControllerDidPressStore:self];
}

- (IBAction)menuButtonPressed:(id)sender {
    [self.delegate pauseViewControllerDidPressMenu:self];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

@end
