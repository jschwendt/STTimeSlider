//
//  STViewController.m
//  STTimeSliderExample
//
//  Created by Sebastien Thiebaud on 4/1/13.
//  Copyright (c) 2013 Sebastien Thiebaud. All rights reserved.
//

#import "STViewController.h"

#import "STTimeSlider.h"

@interface STViewController ()

@end

@implementation STViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _timeSlider = [[STTimeSlider alloc] initWithFrame:CGRectMake(5.0, 5.0, 310.0, 110.0)];
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
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    
//    NSArray *gradientColors = [NSArray arrayWithObjects:
//                               (id)[UIColor blueColor].CGColor,
//                               (id)[UIColor redColor].CGColor, nil];
//    CGFloat gradientLocations[] = {0, 1};
//    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);

//    [_timeSlider setGradient:gradient];
//    [_timeSlider setStrokeColor:[UIColor blueColor]];
}

@end
