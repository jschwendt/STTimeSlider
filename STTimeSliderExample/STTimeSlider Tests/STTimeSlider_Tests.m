//
//  STTimeSlider_Tests.m
//  STTimeSlider Tests
//
//  Created by Sebastien Thiebaud on 3/8/14.
//  Copyright (c) 2014 Sebastien Thiebaud. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "STTimeSlider.h"

@interface STTimeSlider_Tests : XCTestCase <STTimeSliderDelegate>

@property (nonatomic, strong) STTimeSlider *timeSlider;

@end

@implementation STTimeSlider_Tests

- (void)setUp {
    [super setUp];
    
    _timeSlider = [[STTimeSlider alloc] initWithFrame:CGRectMake(5.0, 20.0, 310.0, 40.0)];
    [_timeSlider setDelegate:self];
    [_timeSlider moveToIndex:4];
    _timeSlider.startIndex = 2;
    _timeSlider.mode = STTimeSliderModeMulti;
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - Get/Set

- (void)test_setAndGetGradient_setGradient_gradient {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray *gradientColors = @[(id)[UIColor blueColor].CGColor, (id)[UIColor redColor].CGColor];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    [_timeSlider setGradient:gradient];
    
    XCTAssertEqual(gradient, _timeSlider.gradient, @"Gradient should be %@ but %@ was returned instead.", gradient, _timeSlider.gradient);
}

- (void)test_setAndGetGradientForeground_setGradient_gradient {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSArray *gradientColors = @[(id)[UIColor blueColor].CGColor, (id)[UIColor redColor].CGColor];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    [_timeSlider setGradientForeground:gradient];
    
    XCTAssertEqual(gradient, _timeSlider.gradientForeground, @"Gradient foreground should be %@ but %@ was returned instead.", gradient, _timeSlider.gradientForeground);
}

- (void)test_setAndGetStrokeColor_setColor_color {
    [_timeSlider setStrokeColor:[UIColor purpleColor]];
    
    XCTAssertEqualObjects([UIColor purpleColor], _timeSlider.strokeColor, @"Stroke color should be %@ but %@ was returned instead.", [UIColor purpleColor], _timeSlider.strokeColor);
}

- (void)test_setAndGetStrokeSize_setSize_size {
    [_timeSlider setStrokeSize:5.0];
    
    XCTAssertEqual((float)5.0, (float)_timeSlider.strokeSize, @"Stroke size should be %f but %f was returned instead.", 5.0, _timeSlider.strokeSize);
}

- (void)test_setAndGetShadowColor_setColor_color {
    [_timeSlider setShadowColor:[UIColor greenColor]];
    
    XCTAssertEqualObjects([UIColor greenColor], _timeSlider.shadowColor, @"Shadow color should be %@ but %@ was returned instead.", [UIColor greenColor], _timeSlider.shadowColor);
}

- (void)test_setAndGetShadowSize_setSize_size {
    [_timeSlider setShadowSize:CGSizeMake(5.0, 5.0)];
    
    XCTAssertEqual((float)5.0, (float)_timeSlider.shadowSize.height, @"Shadow size height should be %f but %f was returned instead.", 5.0, _timeSlider.shadowSize.height);
    XCTAssertEqual((float)5.0, (float)_timeSlider.shadowSize.width, @"Shadow size width should be %f but %f was returned instead.", 5.0, _timeSlider.shadowSize.width);
}

- (void)test_setAndGetShadowBlur_setBlur_blur {
    [_timeSlider setShadowBlur:3.0];
    
    XCTAssertEqual((float)3.0, (float)_timeSlider.shadowBlur, @"Shadow blur should be %f but %f was returned instead.", 3.0, _timeSlider.shadowSize.height);
}

- (void)test_setAndGetStrokeSizeForeground_setSize_size {
    [_timeSlider setStrokeSizeForeground:5.0];
    
    XCTAssertEqual((float)5.0, (float)_timeSlider.strokeSizeForeground, @"Stroke size foreground should be %f but %f was returned instead.", 5.0, _timeSlider.strokeSizeForeground);
}

- (void)test_setAndGetRadiusPoint_setRadius_radius {
    [_timeSlider setRadiusPoint:5.0];
    
    XCTAssertEqual((float)6.0, (float)_timeSlider.radiusPoint, @"Radius point should be %f but %f was returned instead.", 6.0, _timeSlider.radiusPoint);
}

- (void)test_setAndGetRadiusCircle_setRadius_radius {
    [_timeSlider setRadiusCircle:10.0];
    
    XCTAssertEqual((float)6.0, (float)_timeSlider.radiusCircle, @"Radius point should be %f but %f was returned instead.", 6.0, _timeSlider.radiusCircle);
}

- (void)test_setAndGetRadiusPointSecondTime_setRadius_radius {
    [_timeSlider setRadiusPoint:10.0];
    
    XCTAssertEqual((float)10.0, (float)_timeSlider.radiusPoint, @"Radius point should be %f but %f was returned instead.", 10.0, _timeSlider.radiusPoint);
}

- (void)test_setAndGetSpaceBetweenPoints_setSpace_space {
    [_timeSlider setSpaceBetweenPoints:15.0];

    XCTAssertEqual((float)15.0, (float)_timeSlider.spaceBetweenPointsLandscape, @"Landscape space between space should be %f but %f was returned instead.", 15.0, _timeSlider.spaceBetweenPointsLandscape);
    XCTAssertEqual((float)15.0, (float)_timeSlider.spaceBetweenPointsPortrait, @"Portrait space between space should be %f but %f was returned instead.", 15.0, _timeSlider.spaceBetweenPointsPortrait);
}

- (void)test_setAndGetSpaceBetweenPointsLandscape_setSpace_space {
    [_timeSlider setSpaceBetweenPointsLandscape:20.0];
    
    XCTAssertEqual((float)20.0, (float)_timeSlider.spaceBetweenPointsLandscape, @"Landscape space between space should be %f but %f was returned instead.", 20.0, _timeSlider.spaceBetweenPointsLandscape);
}

- (void)test_setAndGetSpaceBetweenPointsPortrait_setSpace_space {
    [_timeSlider setSpaceBetweenPointsPortrait:25.0];
    
    XCTAssertEqual((float)25.0, (float)_timeSlider.spaceBetweenPointsPortrait, @"Portrait space between space should be %f but %f was returned instead.", 25.0, _timeSlider.spaceBetweenPointsPortrait);
}

- (void)test_setAndGetNumberOfPoints_setNumber_goodNumber {
    int numberOfPoints = _timeSlider.currentIndex + 4;
    [_timeSlider setNumberOfPoints:numberOfPoints];
    
    XCTAssertEqual(numberOfPoints, (int)_timeSlider.numberOfPoints, @"Number of points should be %d but %d was returned instead.", numberOfPoints, (int)_timeSlider.numberOfPoints);
}

- (void)test_setAndGetNumberOfPointsLessThanMinimum_setNumber_goodNumber {
    float minNumberOfPoints = (_timeSlider.currentIndex + 1) > 2 ? (_timeSlider.currentIndex + 1) : 2;
    int numberOfPoints = _timeSlider.currentIndex;
    [_timeSlider setNumberOfPoints:numberOfPoints];
    
    XCTAssertEqual(numberOfPoints > minNumberOfPoints, (int)_timeSlider.numberOfPoints > minNumberOfPoints, @"Number of points should be more than %d but %d was returned.", (int)minNumberOfPoints, (int)_timeSlider.numberOfPoints);
}

- (void)test_setAndGetModeMulti_setMode_mode {
    [_timeSlider setMode:STTimeSliderModeMulti];
    
    XCTAssertEqual((int)STTimeSliderModeMulti, (int)_timeSlider.mode, @"Mode should be STTimeSliderModeMulti (%d) but %d was returned instead.", (int)STTimeSliderModeMulti, (int)_timeSlider.mode);
}

- (void)test_setAndGetModeSolo_setMode_mode {
    [_timeSlider setMode:STTimeSliderModeSolo];
    
    XCTAssertEqual((int)STTimeSliderModeSolo, (int)_timeSlider.mode, @"Mode should be STTimeSliderModeSolo (%d) but %d was returned instead.", (int)STTimeSliderModeSolo, (int)_timeSlider.mode);
}

@end
