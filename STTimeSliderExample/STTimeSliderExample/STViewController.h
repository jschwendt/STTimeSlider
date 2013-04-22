//
//  STViewController.h
//  STTimeSliderExample
//
//  Created by Sebastien Thiebaud on 4/1/13.
//  Copyright (c) 2013 Sebastien Thiebaud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "STTimeSlider.h"

@interface STViewController : UIViewController <STTimeSliderDelegate>
{
    STTimeSlider *_timeSlider;
}

@property (strong, nonatomic) IBOutlet UILabel *labelIndex;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UISlider *sliderNumberPoints;
@property (strong, nonatomic) IBOutlet UISlider *sliderRadiusPoint;
@property (strong, nonatomic) IBOutlet UISlider *sliderRadiusCircle;
@property (strong, nonatomic) IBOutlet UISlider *sliderLineHeight;
@property (strong, nonatomic) IBOutlet UISlider *sliderDistance;
@property (strong, nonatomic) IBOutlet UISwitch *switchUI;

- (IBAction)changeUI:(id)sender;
- (IBAction)changeSegment:(id)sender;
- (IBAction)changeNumberPoints:(id)sender;
- (IBAction)changeRadiusPoint:(id)sender;
- (IBAction)changeRadiusCircle:(id)sender;
- (IBAction)changeLineHeight:(id)sender;
- (IBAction)changeDistance:(id)sender;

@end
