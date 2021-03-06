//
//  STViewController.m
//  STTimeSliderExample
//
//  Created by Sebastien Thiebaud on 4/1/13.
//  Copyright (c) 2013 Sebastien Thiebaud. All rights reserved.
//

#import "STViewController.h"
#import "STTimeSlider.h"

@interface STViewController () <STTimeSliderDelegate>

@property (strong, nonatomic) IBOutlet UILabel *labelIndex;
@property (strong, nonatomic) IBOutlet UISegmentedControl *modeSegmentedControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *firstSegmentedControl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *finalSegmentedControl;
@property (strong, nonatomic) IBOutlet UISlider *sliderNumberPoints;
@property (strong, nonatomic) IBOutlet UISlider *sliderRadiusPoint;
@property (strong, nonatomic) IBOutlet UISlider *sliderRadiusCircle;
@property (strong, nonatomic) IBOutlet UISlider *sliderLineHeight;
@property (strong, nonatomic) IBOutlet UISlider *sliderDistance;
@property (strong, nonatomic) IBOutlet UISwitch *switchUI;

- (IBAction)changeUI:(id)sender;
- (IBAction)changeMode:(id)sender;
- (IBAction)changeFirst:(id)sender;
- (IBAction)changeFinal:(id)sender;
- (IBAction)changeNumberPoints:(id)sender;
- (IBAction)changeRadiusPoint:(id)sender;
- (IBAction)changeRadiusCircle:(id)sender;
- (IBAction)changeLineHeight:(id)sender;
- (IBAction)changeDistance:(id)sender;

@end

@implementation STViewController {
    STTimeSlider *_timeSlider;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _timeSlider = [[STTimeSlider alloc] initWithFrame:CGRectMake(15.0, 30.0, 310.0, 80.0)];
    _timeSlider.delegate = self;
    _timeSlider.numberOfPoints = 5;
    _timeSlider.radiusPoint = 18.0;
    _timeSlider.heightLine = 13.0;
    _timeSlider.spaceBetweenPointsPortrait = 25.0;
    _timeSlider.radiusCircle = 5.0;
    [_timeSlider moveToIndex:4];
    _timeSlider.startIndex = 2;
    _timeSlider.mode = STTimeSliderModeMulti;
    [self.view addSubview:_timeSlider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    _labelIndex.text = [NSString stringWithFormat:@"Index: %d --- Position %@", _timeSlider.currentIndex, NSStringFromCGPoint([_timeSlider positionForPointAtIndex:_timeSlider.currentIndex])];
}

#pragma mark - STTimeSliderDelegate

- (void)timeSlider:(STTimeSlider *)timeSlider didSelectPointAtIndex:(int)index {
}

- (void)timeSlider:(STTimeSlider *)timeSlider didMoveToPointAtIndex:(int)index {
    _labelIndex.text = [NSString stringWithFormat:@"Index: %d --- Position %@", index, NSStringFromCGPoint([_timeSlider positionForPointAtIndex:index])];
    
    [_finalSegmentedControl setSelectedSegmentIndex:index];
    
    if (_timeSlider.mode == STTimeSliderModeSolo)
        [_firstSegmentedControl setSelectedSegmentIndex:index];
}

#pragma mark - Demo

- (IBAction)changeUI:(id)sender {
    UISwitch *switchUI = (UISwitch *)sender;
    [_timeSlider setTouchEnabled:switchUI.on];
}

- (IBAction)changeMode:(id)sender {
    [_timeSlider setMode:(_modeSegmentedControl.selectedSegmentIndex == 0) ? STTimeSliderModeMulti : STTimeSliderModeSolo];
}

- (IBAction)changeFirst:(id)sender {
    _timeSlider.startIndex = (int)_firstSegmentedControl.selectedSegmentIndex;
    _firstSegmentedControl.selectedSegmentIndex = _timeSlider.startIndex;
}

- (IBAction)changeFinal:(id)sender {
    [_timeSlider moveToIndex:(int)_finalSegmentedControl.selectedSegmentIndex];
    [_finalSegmentedControl setSelectedSegmentIndex:_timeSlider.currentIndex];
    
    _labelIndex.text = [NSString stringWithFormat:@"Index: %d --- Position %@", (int)_finalSegmentedControl.selectedSegmentIndex, NSStringFromCGPoint([_timeSlider positionForPointAtIndex:(int)_finalSegmentedControl.selectedSegmentIndex])];
}

- (IBAction)changeNumberPoints:(id)sender {
    UISlider *slider = (UISlider *)sender;
    
    [_timeSlider setNumberOfPoints:slider.value];
    [_finalSegmentedControl removeAllSegments];
    [_firstSegmentedControl removeAllSegments];
    
    for (int i = 0; i < (int)_timeSlider.numberOfPoints; i++) {
        [_firstSegmentedControl insertSegmentWithTitle:[NSString stringWithFormat:@"%d", i] atIndex:i animated:NO];
        [_finalSegmentedControl insertSegmentWithTitle:[NSString stringWithFormat:@"%d", i] atIndex:i animated:NO];
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
    [_timeSlider setSpaceBetweenPointsPortrait:slider.value];
    [_timeSlider setSpaceBetweenPointsLandscape:slider.value * 0.5];
}

@end
