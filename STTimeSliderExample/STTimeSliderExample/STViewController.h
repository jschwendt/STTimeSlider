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

@end
