//
//  FirstViewController.m
//  My First Timer App
//
//  Created by Jhaybie on 9/20/13.
//  Copyright (c) 2013 Jhaybie. All rights reserved.
//

#import "FirstViewController.h"
#import <AudioToolbox/AudioToolbox.h>


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
- (IBAction)addSecs:      (id)sender;

@end

@implementation FirstViewController

int hours, minutes, seconds, secondsLeft;

- (void)viewDidLoad
{
    [super viewDidLoad];

    secondsLeft = 0;
    [pauseButton setEnabled:NO];
    [timerLabel setHidden: YES];
    [pickerWheel setHidden: NO];
}

- (void)updateCounter:(NSTimer *)theTimer {
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
        
        //Audio services initialization
        
        SystemSoundID sound;
        NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"sample"
                                                  withExtension:@"caf"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &sound);
        AudioServicesPlayAlertSound(sound);
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Timer done"
                                                          message:@""
                                                         delegate:nil
                                                cancelButtonTitle:@"Dismiss"
                                                otherButtonTitles:nil];
        [message show];
        [pickerWheel setHidden: NO];
        [timerLabel setHidden: YES];
        [startButton setTitle: @"Start"
                     forState: UIControlStateNormal];
        AudioServicesRemoveSystemSoundCompletion(sound);
        AudioServicesDisposeSystemSoundID(sound);
    }
}

- (IBAction)startPressed:(id)sender
{
    if (secondsLeft > 0)
    {
        [pauseButton setEnabled: YES];
        if ([startButton.titleLabel.text isEqual: @"Start"])
        {
            [timerLabel setHidden: NO];
            [pickerWheel setHidden: YES];
            
            //Get secondsLeft from pickerWheel values
            
            if (secondsLeft > 0)
            {
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
            [pauseButton setEnabled: NO];
            [timerLabel setHidden: YES];
            [pickerWheel setHidden: NO];
            [timer invalidate];
            timerLabel.text = @"00:00:00";
            
            secondsLeft = 0;
        }
    }
    else
    {
        [pauseButton setEnabled: NO];
        [pickerWheel setHidden: NO];
        [timerLabel setHidden: YES];
        [startButton setTitle: @"Start"
                 forState: UIControlStateNormal];    }
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



//Remove this later!

- (IBAction)addSecs:(id)sender
{
    secondsLeft = secondsLeft + 3;
    hours           = secondsLeft / 3600;
    minutes         = (secondsLeft % 3600) / 60;
    seconds         = (secondsLeft % 3600) % 60;
    timerLabel.text = [NSString stringWithFormat: @"%02d:%02d:%02d", hours, minutes, seconds];
}



@end