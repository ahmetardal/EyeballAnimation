//
//  EyeballAnimationViewController.m
//  EyeballAnimation
//
//  Created by Ahmet Ardal on 4/25/11.
//  Copyright 2011 Ahmet Ardal. All rights reserved.
//

#import "EyeballAnimationViewController.h"


/* -------------------------------------------------------- */
/* uncomment one to change the animation timing method      */
/* -------------------------------------------------------- */
// #define USE_NSTIMER
#define USE_CADISPLAYLINK

#define DegreesToRadians(x)     (M_PI * (x) / 180.0)


@interface EyeballAnimationViewController(Private)
- (void) initializeTimerWithNSTimer;
- (void) initializeTimerWithCADisplayLink;
- (void) animateBallNSTimer:(NSTimer *)timer;
- (void) animateBallCADisplayLink;
- (void) performAnimationStep;
@end


@implementation EyeballAnimationViewController

@synthesize ballImageView;

- (void) initialize
{
    //
    // init movement, rotation and alpha change amounts
    //
    _ballMovement = CGPointMake(2, 2);
    _ballRotation = 4;
    _ballAlphaChange = -0.025f;

    //
    // init timer to perform animations
    //
#ifdef USE_NSTIMER
    [self initializeTimerWithNSTimer];
#else
    [self initializeTimerWithCADisplayLink];
#endif
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        return self;
    }
    
    [self initialize];
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) viewDidUnload
{
}

- (void) dealloc
{
    [self.ballImageView release];
    [super dealloc];
}


#pragma mark -
#pragma mark Private Methods

- (void) initializeTimerWithNSTimer
{
    CGFloat interval = 1.0f / 50.0f;
    [NSTimer scheduledTimerWithTimeInterval:interval
                                     target:self
                                   selector:@selector(animateBallNSTimer:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void) initializeTimerWithCADisplayLink
{
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(animateBallCADisplayLink)];
    _timer.frameInterval = 2;
    [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void) animateBallNSTimer:(NSTimer *)timer
{
    [self performAnimationStep];
}

- (void) animateBallCADisplayLink
{
    [self performAnimationStep];
}

- (void) performAnimationStep
{
    //
    // reposition the ball
    //
    CGPoint ballCenter = self.ballImageView.center;
    CGFloat newX = ballCenter.x + _ballMovement.x;
    CGFloat newY = ballCenter.y + _ballMovement.y;
    self.ballImageView.center = CGPointMake(newX, newY);

    //
    // rotate the ball
    //
    self.ballImageView.transform =
        CGAffineTransformRotate(self.ballImageView.transform, DegreesToRadians(_ballRotation));

    //
    // change the opacity of the ball
    //
    CGFloat newAlpha = self.ballImageView.alpha + _ballAlphaChange;
    self.ballImageView.alpha = newAlpha;

    //
    // change move direction and rotation direction when
    // the ball collides one of the borders of the screen
    //
    ballCenter = self.ballImageView.center;
    if ((ballCenter.x > 300) || (ballCenter.x < 20)) {
        _ballMovement.x *= -1;
        _ballRotation *= -1;
    }
    if ((ballCenter.y > 440) || (ballCenter.y < 20)) {
        _ballMovement.y *= -1;
        _ballRotation *= -1;
    }
    
    //
    // check bounds and reverse the opacity change direction
    //
    if ((newAlpha >= 1.0f) || newAlpha <= 0.15f) {
        _ballAlphaChange *= -1;
    }
}

@end
