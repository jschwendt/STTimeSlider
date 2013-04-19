//
//  STTimeSlider.m
//  STTimeSliderExample
//
//  Created by Sebastien Thiebaud on 4/1/13.
//  Copyright (c) 2013 Sebastien Thiebaud. All rights reserved.
//

#import "STTimeSlider.h"

@implementation STTimeSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        _spaceBetweenPoints = 40.0;
        _numberOfPoints = 5.0;
        _heightLine = 10.0;
        _radiusPoint = 13.0;
        _shadowSize = CGSizeMake(2.0, 2.0);
        _shadowBlur = 2.0;
        _strokeSize = 1.0;
        _strokeColor = [UIColor blackColor];
        _shadowColor = [UIColor colorWithWhite:0.0 alpha:0.30];
        _radiusCircle = 2.0;
        _moveFinalIndex = 0;
        _currentIndex = 0;
        
        _strokeColorForeground = [UIColor colorWithWhite:0.3 alpha:1.0];
        _strokeSizeForeground = 1.0;
        
        _moveLayer = [[STTimeSliderMoveView alloc] initWithFrame:self.bounds];
        [_moveLayer setDelegate:self];
        [self addSubview:_moveLayer];
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        
        NSArray *gradientColors = [NSArray arrayWithObjects:
                                   (id)[UIColor whiteColor].CGColor,
                                   (id)[UIColor colorWithWhite:0.793 alpha:1.000].CGColor, nil];
        CGFloat gradientLocations[] = {0, 1};
        _gradientForeground = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
        
        gradientColors = [NSArray arrayWithObjects:
                          (id)[UIColor colorWithRed:0.571 green:0.120 blue:0.143 alpha:1.000].CGColor,
                          (id)[UIColor colorWithRed:0.970 green:0.264 blue:0.370 alpha:1.000].CGColor, nil];
        _gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
        
        _positionPoints = [NSMutableArray array];
        
        CGColorSpaceRelease(colorSpace);
    }
    return self;
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect
{        
    _context = UIGraphicsGetCurrentContext();
    
    CGRect timelineRect = CGRectMake(self.bounds.origin.x + _strokeSize, self.bounds.origin.y + _strokeSize, _spaceBetweenPoints * (_numberOfPoints + 1) + _radiusPoint * 2.0 * (_numberOfPoints + 2), _radiusPoint * 2.0);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(timelineRect), CGRectGetMinY(timelineRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(timelineRect), CGRectGetMaxY(timelineRect));

    _drawPath = [self backgroundPath];
    _movePath = [self movePath];

    [_strokeColor setStroke];

    CGContextSaveGState(_context);
    CGContextSetShadowWithColor(_context, _shadowSize, _shadowBlur, _shadowColor.CGColor);
    [_drawPath setLineWidth:_strokeSize];
    [_drawPath fill];
    [_drawPath stroke];
    [_drawPath addClip];
    CGContextDrawLinearGradient(_context, _gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(_context);
    
    [_moveLayer setMovePath:_movePath];
    [_moveLayer setStartPoint:startPoint];
    [_moveLayer setEndPoint:endPoint];
    
    [_moveLayer setNeedsDisplay];
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
            [_positionPoints addObject:[NSValue valueWithCGPoint:centerPoint]];
            [path addArcWithCenter:centerPoint radius:_radiusPoint startAngle:angle endAngle:angle * -1.0 clockwise:YES];
            [path addLineToPoint:CGPointMake(centerPoint.x + _radiusPoint + _spaceBetweenPoints, centerPoint.y - _heightLine / 2.0)];
        }
        else if (i == _numberOfPoints - 1)
        {
            [_positionPoints addObject:[NSValue valueWithCGPoint:centerPoint]];
            [path addArcWithCenter:centerPoint radius:_radiusPoint startAngle:M_PI + angle endAngle:M_PI - angle clockwise:YES];
            [path addLineToPoint:CGPointMake(centerPoint.x - _radiusPoint - _spaceBetweenPoints, centerPoint.y + _heightLine / 2.0)];
        }
        else if (i < _numberOfPoints - 1)
        {
            [_positionPoints addObject:[NSValue valueWithCGPoint:centerPoint]];
            [path addArcWithCenter:centerPoint radius:_radiusPoint startAngle:M_PI + angle endAngle:angle * -1.0 clockwise:YES];
            [path addLineToPoint:CGPointMake(centerPoint.x + _radiusPoint + _spaceBetweenPoints, centerPoint.y - _heightLine / 2.0)];
        }
        else if (i >= _numberOfPoints)
        {
            [_positionPoints addObject:[NSValue valueWithCGPoint:centerPoint]];
            [path addArcWithCenter:centerPoint radius:_radiusPoint startAngle:angle endAngle:M_PI - angle clockwise:YES];
            [path addLineToPoint:CGPointMake(centerPoint.x - _radiusPoint - _spaceBetweenPoints, centerPoint.y + _heightLine / 2.0)];
        }
    }
            
    return path;
}

- (UIBezierPath *)movePath
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    float heightLine = _heightLine - 4.0;
    float radiusPoint = _radiusPoint - 3.0;
    
    float angle = heightLine / 2.0 / radiusPoint;
    
    if (_moveFinalIndex == 0)
    {
        CGPoint centerPoint = CGPointMake(_radiusPoint + 1.0, _radiusPoint + 1.0);
        [path addArcWithCenter:centerPoint radius:radiusPoint startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];
        [path addArcWithCenter:centerPoint radius:_radiusCircle startAngle:0.0 endAngle:M_PI * 2.0 clockwise:NO];
    }
    else
    {
        int moveTo = _moveFinalIndex + 1;
        
        for (int i = 0; i < (moveTo - 2) * 2 + 2; i++)
        {
            int pointNbr = (i >= moveTo) ? (moveTo - 2) - (i - moveTo) : i;
            
            CGPoint centerPoint = CGPointMake(_radiusPoint + _spaceBetweenPoints * pointNbr + _radiusPoint * 2.0 * pointNbr + 1.0, _radiusPoint + 1.0);
            
            if (i == 0)
            {
                [path addArcWithCenter:centerPoint radius:radiusPoint startAngle:angle endAngle:angle * -1.0 clockwise:YES];
                
                CGPoint currentPoint = path.currentPoint;
                
                [path addArcWithCenter:centerPoint radius:_radiusCircle startAngle:0.0 endAngle:M_PI * 2.0 clockwise:NO];
                [path addLineToPoint:currentPoint];
                [path addLineToPoint:CGPointMake(centerPoint.x + radiusPoint + _spaceBetweenPoints, centerPoint.y - heightLine / 2.0)];
            }
            else if (i == moveTo - 1)
            {
                [path addArcWithCenter:centerPoint radius:radiusPoint startAngle:M_PI + angle endAngle:M_PI - angle clockwise:YES];
                
                CGPoint currentPoint = path.currentPoint;
                
                [path addArcWithCenter:centerPoint radius:_radiusCircle startAngle:0.0 endAngle:M_PI * 2.0 clockwise:NO];
                [path addLineToPoint:currentPoint];
                [path addLineToPoint:CGPointMake(centerPoint.x - radiusPoint - _spaceBetweenPoints, centerPoint.y + heightLine / 2.0)];
            }
            else if (i < moveTo - 1)
            {
                [path addArcWithCenter:centerPoint radius:radiusPoint startAngle:M_PI + angle endAngle:angle * -1.0 clockwise:YES];
                
                CGPoint currentPoint = path.currentPoint;
                
                [path addArcWithCenter:centerPoint radius:_radiusCircle startAngle:0.0 endAngle:M_PI * 2.0 clockwise:NO];
                [path addLineToPoint:currentPoint];

                [path addLineToPoint:CGPointMake(centerPoint.x + radiusPoint + _spaceBetweenPoints, centerPoint.y - heightLine / 2.0)];
            }
            else if (i >= moveTo)
            {
                [path addArcWithCenter:centerPoint radius:radiusPoint startAngle:angle endAngle:M_PI - angle clockwise:YES];
                [path addLineToPoint:CGPointMake(centerPoint.x - radiusPoint - _spaceBetweenPoints, centerPoint.y + heightLine / 2.0)];
            }
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
            
            if ([_delegate respondsToSelector:@selector(timeSlider:didSelectPointAtIndex:)])
            {
                [_delegate timeSlider:self didSelectPointAtIndex:nbrPoint];
            }
            
            [self moveToIndex:nbrPoint];
        }
    }
}

#pragma mark -
#pragma mark Move the index

- (void)moveToIndex:(int)index
{
    _moveFinalIndex = index;
    
    _movePath = [self movePath];
    [_moveLayer setMovePath:_movePath];
    [_moveLayer setNeedsDisplay];
    
    _currentIndex = index;
}

#pragma mark -
#pragma mark Setters

- (void)setGradient:(CGGradientRef)gradient
{
    _gradient = gradient;
    [self setNeedsDisplay];
}

- (void)setGradientForeground:(CGGradientRef)gradientForeground
{
    _gradientForeground = gradientForeground;
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
