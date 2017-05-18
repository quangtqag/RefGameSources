//
//  ViewController.m
//  CERangeSlider
//
//  Created by Quang Tran on 5/13/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "ViewController.h"
#import "CERangeSlider.h"

@interface ViewController ()

@end

@implementation ViewController
{
  CERangeSlider* _rangeSlider;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  NSUInteger margin = 20;
  CGRect sliderFrame = CGRectMake(margin, 200, self.view.frame.size.width - margin * 2, 30);
  _rangeSlider = [[CERangeSlider alloc] initWithFrame:sliderFrame];
  
  [self.view addSubview:_rangeSlider];
  
  [_rangeSlider addTarget:self action:@selector(slideValueChanged:) forControlEvents:UIControlEventValueChanged];

//  [self performSelector:@selector(updateState) withObject:nil afterDelay:1.0f];

}

- (void)updateState
{
  _rangeSlider.trackHighlightColour = [UIColor redColor];
  _rangeSlider.curvaceousness = 0.0;
}

- (void)slideValueChanged:(id)control
{
  NSLog(@"Slider value changed: (%.2f,%.2f)", _rangeSlider.lowerValue, _rangeSlider.upperValue);
}

@end
