//
//  SecondViewController.m
//  My First Timer App
//
//  Created by Jhaybie on 9/20/13.
//  Copyright (c) 2013 Jhaybie. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
{
    __weak IBOutlet UILabel *minutesLabel;
    __weak IBOutlet UIButton *startButton;
    __weak IBOutlet UIButton *resetButton;
    
    NSTimer *timer;
}

- (IBAction)startPressed:(id)sender;
- (IBAction)resetPressed:(id)sender;

@end



@implementation SecondViewController


int hours, minutes, seconds, currentTime;


- (void)viewDidLoad
{
    [super viewDidLoad];
	currentTime = 0;
    minutesLabel.text = @"00:00:00";
    [resetButton setEnabled: NO];
}


- (void)updateCounter:(NSTimer *)theTimer
{
    currentTime++;
    hours           = currentTime / 3600;
    minutes         = (currentTime % 3600) / 60;
    seconds         = (currentTime % 3600) % 60;
    minutesLabel.text = [NSString stringWithFormat: @"%02d:%02d:%02d", hours, minutes, seconds];
    }


- (IBAction)startPressed:(id)sender
{
    [resetButton setEnabled: YES];
    if ([startButton.titleLabel.text isEqual: @"Start"] ||
        [startButton.titleLabel.text isEqual: @"Resume"])
    {
        [startButton setTitle: @"Pause"
                     forState: UIControlStateNormal];
        timer = [NSTimer scheduledTimerWithTimeInterval: 1.0f
                                                 target: self
                                               selector: @selector(updateCounter:)
                                               userInfo: nil
                                                repeats: YES];
    }
    else
    {
        [startButton setTitle: @"Resume"
                     forState: UIControlStateNormal];
        [timer invalidate];
    }
}


- (IBAction)resetPressed:(id)sender
{
    [resetButton setEnabled: NO];
    [startButton setTitle: @"Start"
                 forState:UIControlStateNormal];
    minutesLabel.text = @"00:00:00";
    [timer invalidate];
    currentTime = 0;
}


@end
