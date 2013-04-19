//
//  STTimeSlider.h
//  STTimeSliderExample
//
//  Created by Sebastien Thiebaud on 4/1/13.
//  Copyright (c) 2013 Sebastien Thiebaud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STTimeSliderDelegate <NSObject>

@optional
- (void)pointSelectedAtIndex:(int)index;
- (void)movedToIndex:(int)index;

@end

@interface STTimeSlider : UIView
{
    UIBezierPath *_drawPath;
    CGContextRef _context;
    
    UIBezierPath *_movePath;
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

@property (nonatomic, assign, readonly) int currentIndex;

@property (nonatomic, retain) id<STTimeSliderDelegate> delegate;

- (void)setGradient:(CGGradientRef)gradient;

@end
