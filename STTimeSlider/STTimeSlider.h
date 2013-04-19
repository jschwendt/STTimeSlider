//
//  STTimeSlider.h
//  STTimeSliderExample
//
//  Created by Sebastien Thiebaud on 4/1/13.
//  Copyright (c) 2013 Sebastien Thiebaud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STTimeSlider : UIView
{
    UIBezierPath *_drawPath;
    CGContextRef _context;
}

@property (nonatomic, assign) float spaceBetweenPoints;
@property (nonatomic, assign) float numberOfPoints;
@property (nonatomic, assign) float heightLine;
@property (nonatomic, assign) float radiusPoint;
@property (nonatomic, assign) CGSize shadowSize;
@property (nonatomic, assign) float shadowBlur;
@property (nonatomic, assign) float strokeSize;
@property (nonatomic, retain) UIColor *strokeColor;
@property (nonatomic, retain) UIColor *shadowColor;
@property (nonatomic, assign) CGGradientRef gradient;

- (void)setGradient:(CGGradientRef)gradient;

@end
