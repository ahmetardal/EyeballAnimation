//
//  EyeballAnimationAppDelegate.h
//  EyeballAnimation
//
//  Created by Ahmet Ardal on 4/25/11.
//  Copyright 2011 Ahmet Ardal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EyeballAnimationViewController;

@interface EyeballAnimationAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    EyeballAnimationViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet EyeballAnimationViewController *viewController;

@end

