//
//  STViewController.m
//  STTimeSliderExample
//
//  Created by Sebastien Thiebaud on 4/1/13.
//  Copyright (c) 2013 Sebastien Thiebaud. All rights reserved.
//

#import "STViewController.h"

@interface STViewController ()

@end

@implementation STViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _timeSlider = [[STTimeSlider alloc] initWithFrame:CGRectMake(5.0, 5.0, 310.0, 110.0)];
    [_timeSlider setDelegate:self];
    [self.view addSubview:_timeSlider];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
}

#pragma mark -
#pragma mark STTimeSlider Delegate

- (void)timeSlider:(STTimeSlider *)timeSlider didSelectPointAtIndex:(int)index
{
    NSLog(@"TimeSlider %@ at Index %d", timeSlider, index);
}

@end
