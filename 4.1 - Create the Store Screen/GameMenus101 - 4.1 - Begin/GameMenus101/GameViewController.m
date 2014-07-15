//
//  GameViewController.m
//  GameMenus101 - 1.2
//
//  Created by Paul on 4/14/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

static const int kRedViewSpeed = 2;
static const int kBlueViewSpeed = 4;
static const double kRemovedPointsPerSecond = 150.5;

#import "GameViewController.h"

@interface GameViewController () {
    UIView *_redView;
    UIView *_blueView;
    
    int _points;
    NSTimer *_gameLoopTimer;
    
    int _redViewSpeed;
    int _blueViewSpeed;
    
    BOOL _pauseMovement;
    
    double _pointsToRemove;
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

    [self startGameLoop];

    _blueViewSpeed = kBlueViewSpeed;
    _redViewSpeed = kRedViewSpeed;
    
    _pauseMovement = NO;
}

- (void)startGameLoop {
    if(!_gameLoopTimer) {
        _gameLoopTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(gameLoopUpdate:) userInfo:nil repeats:YES];
    }
}

- (void)stopGameLoop {
    [_gameLoopTimer invalidate];
    _gameLoopTimer = nil;
}

- (void)gameLoopUpdate:(NSTimer *)timer {
    NSLog(@"Timer: %f", timer.timeInterval);
    
    if(!_pauseMovement) {
        _redView.center = CGPointMake(_redView.center.x + _redViewSpeed,
                                      _redView.center.y);
        
        if(_redView.center.x + _redView.bounds.size.width / 2 > self.view.bounds.size.width) {
            _redViewSpeed = -1 * kRedViewSpeed;
        } else if(_redView.center.x - _redView.bounds.size.width / 2 < 0) {
            _redViewSpeed = kRedViewSpeed;
        }
        
        _blueView.center = CGPointMake(_blueView.center.x,
                                       _blueView.center.y + _blueViewSpeed);
        
        if(_blueView.center.y + _blueView.bounds.size.height / 2 > self.view.bounds.size.height) {
            _blueViewSpeed = -1 * kBlueViewSpeed;
        } else if(_blueView.center.y - _blueView.bounds.size.height / 2 < 0) {
            _blueViewSpeed = kBlueViewSpeed;
        }
    }
    
    // Calculate some points
//    _points -= .1;
    
    _pointsToRemove += timer.timeInterval * kRemovedPointsPerSecond;
    
    double wholePoints = 0;
    // 3.14
    // 0.14  :    3.0
    _pointsToRemove = modf(_pointsToRemove, &wholePoints);
    
    NSLog(@"pointsToRemove: %f %f", _pointsToRemove, wholePoints);
    
    _points -= wholePoints;
    
    
    self.pointsLabel.text = [@(_points) stringValue];
}


- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture {
    
    NSLog(@"gesture");
    
    if(UIGestureRecognizerStateBegan == gesture.state) {
        _pauseMovement = YES;
    } else if(UIGestureRecognizerStateChanged == gesture.state) {
        
        // Use translation offset
        CGPoint translation = [gesture translationInView:gesture.view];
        gesture.view.center = CGPointMake(gesture.view.center.x + translation.x,
                                          gesture.view.center.y + translation.y);
        // clear translation
        [gesture setTranslation:CGPointZero inView:gesture.view];
        
        _points += abs(translation.x + translation.y);
        self.pointsLabel.text = [@(_points) stringValue];
    } else if(UIGestureRecognizerStateEnded == gesture.state ||
              UIGestureRecognizerStateFailed == gesture.state ||
              UIGestureRecognizerStateCancelled == gesture.state) {
        _pauseMovement = NO;
    }
    
}

- (IBAction)pauseButtonPressed:(id)sender {
    [self.delegate gameViewControllerDidPressPause:self];

}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
