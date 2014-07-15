//
//  GameViewController.m
//  GameMenus101 - 1.2
//
//  Created by Paul on 4/14/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
- (IBAction)pauseButtonPressed:(id)sender;

@end

@implementation GameViewController

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



- (IBAction)pauseButtonPressed:(id)sender {
    [self.delegate gameViewControllerDidPressPause:self];

}


@end
