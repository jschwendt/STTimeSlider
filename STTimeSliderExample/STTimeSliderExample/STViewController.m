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
    
    _timeSlider = [[STTimeSlider alloc] initWithFrame:CGRectMake(5.0, 5.0, 310.0, 40.0)];
    [_timeSlider setDelegate:self];
    [self.view addSubview:_timeSlider];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    _labelIndex.text = [NSString stringWithFormat:@"Index: %d --- Position %@", _timeSlider.currentIndex, NSStringFromCGPoint([_timeSlider positionForPointAtIndex:_timeSlider.currentIndex])];
}

#pragma mark -
#pragma mark STTimeSlider Delegate

- (void)timeSlider:(STTimeSlider *)timeSlider didSelectPointAtIndex:(int)index
{
    _labelIndex.text = [NSString stringWithFormat:@"Index: %d --- Position %@", index, NSStringFromCGPoint([_timeSlider positionForPointAtIndex:index])];
    [_segmentedControl setSelectedSegmentIndex:index];
}

#pragma mark -
#pragma mark Demo

- (IBAction)changeUI:(id)sender {
    UISwitch *switchUI = (UISwitch *)sender;
    
    [_timeSlider setTouchEnabled:switchUI.on];
}

- (IBAction)changeSegment:(id)sender {
    [_timeSlider moveToIndex:_segmentedControl.selectedSegmentIndex];
    
    _labelIndex.text = [NSString stringWithFormat:@"Index: %d --- Position %@", _segmentedControl.selectedSegmentIndex, NSStringFromCGPoint([_timeSlider positionForPointAtIndex:_segmentedControl.selectedSegmentIndex])];
}

- (IBAction)changeNumberPoints:(id)sender {
    UISlider *slider = (UISlider *)sender;
    
    [_timeSlider setNumberOfPoints:slider.value];
    [_segmentedControl removeAllSegments];
    
    for (int i = 0; i < (int)_timeSlider.numberOfPoints; i++) {
        [_segmentedControl insertSegmentWithTitle:[NSString stringWithFormat:@"%d", i] atIndex:i animated:NO];
    }
}

- (IBAction)changeRadiusPoint:(id)sender {
    UISlider *slider = (UISlider *)sender;
    
    [_timeSlider setRadiusPoint:slider.value];
}

- (IBAction)changeRadiusCircle:(id)sender {
    UISlider *slider = (UISlider *)sender;
    
    [_timeSlider setRadiusCircle:slider.value];
}

- (IBAction)changeLineHeight:(id)sender {
    UISlider *slider = (UISlider *)sender;
    
    [_timeSlider setHeightLine:slider.value];
}

- (IBAction)changeDistance:(id)sender {
    UISlider *slider = (UISlider *)sender;
    
    [_timeSlider setSpaceBetweenPoints:slider.value];
}

@end
