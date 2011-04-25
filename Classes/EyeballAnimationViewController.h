//
//  EyeballAnimationViewController.h
//  EyeballAnimation
//
//  Created by Ahmet Ardal on 4/25/11.
//  Copyright 2011 Ahmet Ardal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CADisplayLink.h>

@interface EyeballAnimationViewController: UIViewController
{
    UIImageView *ballImageView;

    CGPoint _ballMovement;      // in x, y
    CGFloat _ballRotation;      // in degrees
    CGFloat _ballAlphaChange;   // between 0-1

    CADisplayLink *_timer;  // needs QuartzCore.framework to be linked with the project
}

@property (nonatomic, retain) IBOutlet UIImageView *ballImageView;

@end
