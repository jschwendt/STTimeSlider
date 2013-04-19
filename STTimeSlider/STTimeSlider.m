//
//  STTimeSlider.m
//  STTimeSliderExample
//
//  Created by Sebastien Thiebaud on 4/1/13.
//  Copyright (c) 2013 Sebastien Thiebaud. All rights reserved.
//

#import "STTimeSlider.h"
#import <QuartzCore/QuartzCore.h>

@implementation STTimeSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _spaceBetweenPoints = 40.0;
        _numberOfPoints = 3.0;
        _heightLine = 10.0;
        _radiusPoint = 10.0;
        _shadowSize = CGSizeMake(2.0, 2.0);
        _shadowBlur = 5.0;
        _strokeSize = 1.0;
        _strokeColor = [UIColor blackColor];
        _shadowColor = [UIColor blackColor];
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        
        NSArray *gradientColors = [NSArray arrayWithObjects:
                                   (id)[UIColor grayColor].CGColor,
                                   (id)[UIColor whiteColor].CGColor, nil];
        CGFloat gradientLocations[] = {0, 1};
        
        _gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
        
//        [self setNeedsDisplay];
    }
    return self;
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect
{    
    [_strokeColor setStroke];
    
    _context = UIGraphicsGetCurrentContext();
    
    CGRect timelineRect = CGRectMake(self.bounds.origin.x + _strokeSize, self.bounds.origin.y + _strokeSize, _spaceBetweenPoints * (_numberOfPoints + 1) + _radiusPoint * 2.0 * (_numberOfPoints + 2), _radiusPoint * 2.0);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(timelineRect), CGRectGetMinY(timelineRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(timelineRect), CGRectGetMaxY(timelineRect));

    _drawPath = [self backgroundPath];

    CGContextSaveGState(_context);

    CGContextSetShadowWithColor(_context, _shadowSize, _shadowBlur, _shadowColor.CGColor);

    [_drawPath setLineWidth:_strokeSize];
    
    [_drawPath fill];
    [_drawPath stroke];
    [_drawPath addClip];
    
    CGContextDrawLinearGradient(_context, _gradient, startPoint, endPoint, 0);

    CGContextRestoreGState(_context);
}

- (UIBezierPath *)backgroundPath
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    float angle = _heightLine / 2.0 / _radiusPoint;
    
    for (int i = 0; i < (_numberOfPoints - 2) * 2 + 2; i++)
    {
        int pointNbr = (i >= _numberOfPoints) ? (_numberOfPoints - 2) - (i - _numberOfPoints) : i;
        
        CGPoint centerPoint = CGPointMake(_radiusPoint + _spaceBetweenPoints * pointNbr + _radiusPoint * 2.0 * pointNbr + _strokeSize, _radiusPoint + _strokeSize);
        
        if (i == 0)
        {
            [path addArcWithCenter:centerPoint radius:_radiusPoint startAngle:angle endAngle:angle * -1.0 clockwise:YES];
            [path addLineToPoint:CGPointMake(centerPoint.x + _radiusPoint + _spaceBetweenPoints, centerPoint.y - _heightLine / 2.0)];
        }
        else if (i == _numberOfPoints - 1)
        {
            [path addArcWithCenter:centerPoint radius:_radiusPoint startAngle:M_PI + angle endAngle:M_PI - angle clockwise:YES];
            [path addLineToPoint:CGPointMake(centerPoint.x - _radiusPoint - _spaceBetweenPoints, centerPoint.y + _heightLine / 2.0)];
        }
        else if (i < _numberOfPoints - 1)
        {
            [path addArcWithCenter:centerPoint radius:_radiusPoint startAngle:M_PI + angle endAngle:angle * -1.0 clockwise:YES];
            [path addLineToPoint:CGPointMake(centerPoint.x + _radiusPoint + _spaceBetweenPoints, centerPoint.y - _heightLine / 2.0)];
        }
        else if (i >= _numberOfPoints)
        {
            [path addArcWithCenter:centerPoint radius:_radiusPoint startAngle:angle endAngle:M_PI - angle clockwise:YES];
            [path addLineToPoint:CGPointMake(centerPoint.x - _radiusPoint - _spaceBetweenPoints, centerPoint.y + _heightLine / 2.0)];
        }
    }
            
    return path;
}

#pragma mark -
#pragma mark User touch

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    CGContextSaveGState(_context);
    CGContextAddPath(_context, _drawPath.CGPath);

    BOOL isInPath = CGContextPathContainsPoint(_context, touchPoint, kCGPathFillStroke);
    
    CGContextRestoreGState(_context);

    if (isInPath)
    {
        float x = touchPoint.x;
        x -= _strokeSize;
        
        float posX = (int)x % (int)(_spaceBetweenPoints + _radiusPoint * 2.0);
        posX -= _radiusPoint;

        if (fabs(posX) <= _radiusPoint)
        {
            int nbrPoint = (float)x / (float)(_spaceBetweenPoints + _radiusPoint * 2.0);
            
            if ([_delegate respondsToSelector:@selector(pointSelectedAtIndex:)])
            {
                [_delegate pointSelectedAtIndex:nbrPoint];
            }
        }
    }
}

#pragma mark -
#pragma mark Setters

- (void)setGradient:(CGGradientRef)gradient
{
    _gradient = gradient;
    [self setNeedsDisplay];
}

- (void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor = strokeColor;
    [self setNeedsDisplay];
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    _shadowColor = shadowColor;
    [self setNeedsDisplay];
}

- (void)setShadowSize:(CGSize)shadowSize
{
    _shadowSize = shadowSize;
    [self setNeedsDisplay];
}

- (void)setShadowBlur:(float)shadowBlur
{
    _shadowBlur = shadowBlur;
    [self setNeedsDisplay];
}

- (void)setStrokeSize:(float)strokeSize
{
    _strokeSize = strokeSize;
    [self setNeedsDisplay];
}

- (void)setRadiusPoint:(float)radiusPoint
{
    _radiusPoint = radiusPoint;
    [self setNeedsDisplay];
}

- (void)setNumberOfPoints:(float)numberOfPoints
{
    if (numberOfPoints < 2)
    {
        _numberOfPoints = 2;
    }
    else
    {
        _numberOfPoints = numberOfPoints;
    }
    
    [self setNeedsDisplay];
}

- (void)setHeightLine:(float)heightLine
{
    _heightLine = heightLine;
    [self setNeedsDisplay];
}

@end
