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
    [_timeSlider setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_timeSlider];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [_timeSlider setNumberOfPoints:5];
    
    [_timeSlider setShadowBlur:2.0];
    [_timeSlider setShadowColor:[UIColor colorWithWhite:0.0 alpha:0.30]];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSArray *gradientColors = [NSArray arrayWithObjects:
                               (id)[UIColor whiteColor].CGColor,
                               (id)[UIColor colorWithWhite:0.888 alpha:1.000].CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);

    [_timeSlider setGradientForeground:gradient];
    
    gradientColors = [NSArray arrayWithObjects:
                               (id)[UIColor colorWithRed:0.571 green:0.120 blue:0.143 alpha:1.000].CGColor,
                               (id)[UIColor colorWithRed:0.970 green:0.264 blue:0.370 alpha:1.000].CGColor, nil];
    gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    [_timeSlider setGradient:gradient];

    //    [_timeSlider setStrokeColor:[UIColor blueColor]];
}

#pragma mark -
#pragma mark STTimeSlider Delegate

- (void)timeSlider:(STTimeSlider *)timeSlider didSelectPointAtIndex:(int)index
{
    NSLog(@"timeslider %@ point %d", timeSlider, index);
}

@end
