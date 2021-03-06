//
//  FirstViewController.m
//  My First Timer App
//
//  Created by Jhaybie on 9/20/13.
//  Copyright (c) 2013 Jhaybie. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
{
    __weak IBOutlet UILabel      *timerLabel;
    __weak IBOutlet UIDatePicker *pickerWheel;
    __weak IBOutlet UIButton     *startButton;
    __weak IBOutlet UIButton     *pauseButton;
    NSTimer *timer;
}
- (IBAction)startPressed: (id)sender;
- (IBAction)pausePressed: (id)sender;
@end


@implementation FirstViewController

int hours, minutes, seconds, secondsLeft;


- (void)viewDidLoad
{
    [super viewDidLoad];
    secondsLeft = 60;
    [pauseButton setEnabled:NO];
    [timerLabel setHidden: YES];
    [pickerWheel setHidden: NO];
    
    //Assigns the custom font for the timer label
    
    [timerLabel setFont:[UIFont fontWithName:@"Atomic Clock Radio" size:45]];
}

//Releases the sound object when the user dismisses the UIAlertView message

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AudioServicesRemoveSystemSoundCompletion(soundID);
    AudioServicesDisposeSystemSoundID(soundID);
}


- (void)updateCounter:(NSTimer *)theTimer
{
    if (secondsLeft > 0 )
    {
        secondsLeft--;
        hours           = secondsLeft / 3600;
        minutes         = (secondsLeft % 3600) / 60;
        seconds         = (secondsLeft % 3600) % 60;
        timerLabel.text = [NSString stringWithFormat: @"%02d:%02d:%02d", hours, minutes, seconds];
    }
    else
    {
        [timer invalidate];
        timerLabel.text = @"00:00:00";
        secondsLeft     = 0;
        
        //AudioServices initialization
        
        NSURL *soundURL   = [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource: @"alarm"
                                                                                    ofType: @"wav"]];
        AudioServicesCreateSystemSoundID ((__bridge CFURLRef) soundURL, &soundID);
        AudioServicesPlayAlertSound (soundID);

        
        //Generate a UIAlertView when timer is done
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle: @"Timer done"
                                                          message: @""
                                                         delegate: self
                                                cancelButtonTitle: @"Dismiss"
                                                otherButtonTitles: nil];
        [message show];
        
        [pickerWheel setHidden: NO];
        [timerLabel  setHidden: YES];
        [startButton  setTitle: @"Start"
                      forState: UIControlStateNormal];
    }
}


- (IBAction)startPressed:(id)sender
{
    secondsLeft = @(pickerWheel.countDownDuration).intValue;
    if (secondsLeft > 0)
    {
        [pauseButton setEnabled: YES];
        if ([startButton.titleLabel.text isEqual: @"Start"])
        {
            [timerLabel setHidden: NO];
            [pickerWheel setHidden: YES];
            secondsLeft = @(pickerWheel.countDownDuration).intValue;
            if (secondsLeft > 0)
            {
                hours           = secondsLeft / 3600;
                minutes         = (secondsLeft % 3600) / 60;
                seconds         = (secondsLeft % 3600) % 60;
                timerLabel.text = [NSString stringWithFormat: @"%02d:%02d:%02d", hours, minutes, seconds];
                [startButton setTitle: @"Cancel"
                             forState: UIControlStateNormal];
                timer = [NSTimer scheduledTimerWithTimeInterval: 1.0f
                                                         target: self
                                                       selector: @selector(updateCounter:)
                                                       userInfo: nil
                                                        repeats: YES];
            }
        }
        else
        {
            [startButton setTitle: @"Start"
                         forState: UIControlStateNormal];
            [pauseButton setTitle: @"Pause"
                         forState: UIControlStateNormal];
            startButton.titleLabel.text = @"Start";
            timerLabel.text = @"00:00:00";
            [pauseButton setEnabled: NO];
            [timerLabel  setHidden: YES];
            [pickerWheel setHidden: NO];
            [timer invalidate];
            secondsLeft = 0;
        }
    }
    else
    {
        [pauseButton setEnabled: NO];
        [pickerWheel  setHidden: NO];
        [timerLabel   setHidden: YES];
        [startButton   setTitle: @"Start"
                       forState: UIControlStateNormal];
    }
}


- (IBAction)pausePressed:(id)sender
{
    if ([pauseButton.titleLabel.text isEqual: @"Pause"])
    {
        if (secondsLeft > 0)
        {
            [pauseButton setTitle: @"Resume"
                         forState: UIControlStateNormal];
            [timer invalidate];
            hours           = secondsLeft / 3600;
            minutes         = (secondsLeft % 3600) / 60;
            seconds         = (secondsLeft % 3600) % 60;
            timerLabel.text = [NSString stringWithFormat: @"%02d:%02d:%02d", hours, minutes, seconds];
        }
    }
    else
    {
        [pauseButton setTitle: @"Pause"
                     forState: UIControlStateNormal];
        [timer invalidate];
        timer = [NSTimer scheduledTimerWithTimeInterval: 1.0f
                                                 target: self
                                               selector: @selector(updateCounter:)
                                               userInfo: nil
                                                repeats: YES];
    }
}


@end