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
    XCTAssertEqual(5.0, _timeSlider.shadowSize.width, @"Shadow size width should be %f but %f was returned instead.", 5.0, _timeSlider.shadowSize.width);
}

- (void)test_setAndGetShadowBlur_setBlur_blur {
    [_timeSlider setShadowBlur:3.0];
    
    XCTAssertEqual((float)3.0, (float)_timeSlider.shadowBlur, @"Shadow blur should be %f but %f was returned instead.", 3.0, _timeSlider.shadowSize.height);
}

- (void)test_setAndGetStrokeSizeForeground_setSize_size {
    [_timeSlider setStrokeSizeForeground:5.0];
    
    XCTAssertEqual((float)5.0, (float)_timeSlider.strokeSizeForeground, @"Stroke size foreground should be %f but %f was returned instead.", 5.0, _timeSlider.strokeSizeForeground);
}

@end
