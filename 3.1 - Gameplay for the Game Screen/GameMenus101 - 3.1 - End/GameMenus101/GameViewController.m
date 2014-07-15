//
//  GameViewController.m
//  GameMenus101 - 1.2
//
//  Created by Paul on 4/14/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController () {
    UIView *_redView;
    UIView *_blueView;
    
    int _points;
}


- (IBAction)pauseButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;

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

    _redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_redView];
    
    _blueView = [[UIView alloc] initWithFrame:CGRectMake(300, 100, 100, 100)];
    _blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_blueView];


    // Gesture to use touch input
    UIPanGestureRecognizer *redGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [_redView addGestureRecognizer:redGesture];
    
    UIPanGestureRecognizer *blueGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [_blueView addGestureRecognizer:blueGesture];


}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture {
    
    NSLog(@"gesture");
    

    
    if(UIGestureRecognizerStateChanged == gesture.state) {
        
        // Use translation offset
        CGPoint translation = [gesture translationInView:gesture.view];
        gesture.view.center = CGPointMake(gesture.view.center.x + translation.x,
                                          gesture.view.center.y + translation.y);
        // clear translation
        [gesture setTranslation:CGPointZero inView:gesture.view];
        
        _points += abs(translation.x + translation.y);
        self.pointsLabel.text = [@(_points) stringValue];
    }
    
}

- (IBAction)pauseButtonPressed:(id)sender {
    [self.delegate gameViewControllerDidPressPause:self];

}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
