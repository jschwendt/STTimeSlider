# STTimeSlider

A custom component like UISegmentedControl highly customizable.

![STTimeSlider screenshot](https://raw.github.com/SebastienThiebaud/STTimeSlider/master/screenshot.png "STTimeSlider Screenshot")

## Documentation

Please include these 4 files:

- `STTimeSlider.h`
- `STTimeSlider.m`
- `STTimeSliderModeView.h`
- `STTimeSliderModeView.m`

And include `QuartzCore.framework`.

This plugin is highly customizable. The official documentation is available here: http://doc.sebastienthiebaud.us/Classes/STTimeSlider.html

## Demo

Build and run the project STTimeSliderExample in Xcode to see `STTimeSlider` in action. 

## Example Usage

``` objective-c
    STTimeSlider *timeSlider = [[STTimeSlider alloc] initWithFrame:CGRectMake(5.0, 5.0, 310.0, 110.0)];
    [*timeSlider setDelegate:self];
    [self.view addSubview:*timeSlider];
```

Don't forget to implement`STTimeSliderDelegate` protocol in your ViewController. Without it, you won't be able to detect when the user will change the index:

``` objective-c
    - (void)timeSlider:(STTimeSlider *)timeSlider didSelectPointAtIndex:(int)index
    {
        NSLog(@"TimeSlider %@ at Index %d", timeSlider, index);
    }
```

You can change the index of the slider with `- (void)moveToIndex:(int)index;`.

## Contact

Sebastien Thiebaud

- http://github.com/SebastienThiebaud
- http://twitter.com/SebThiebaud

## License

STTimeSlider is available under the MIT license.

