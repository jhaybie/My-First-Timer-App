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
    __weak IBOutlet UILabel *millisecsLabel;
    __weak IBOutlet UILabel *minutesLabel;
}

- (IBAction)startPressed:(id)sender;
- (IBAction)resetPressed:(id)sender;

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startPressed:(id)sender {
}

- (IBAction)resetPressed:(id)sender {
}
@end
