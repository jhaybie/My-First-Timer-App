//
//  FirstViewController.h
//  My First Timer App
//
//  Created by Jhaybie on 9/20/13.
//  Copyright (c) 2013 Jhaybie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface FirstViewController : UIViewController <UIAlertViewDelegate>
{
	SystemSoundID soundID;
}

-(void)updateCounter:(NSTimer *)theTimer;

@end
